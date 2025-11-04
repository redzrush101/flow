#!/usr/bin/env bash

# Flow Framework Validation Utilities
# Provides comprehensive validation for deployment and operations

# Validate deployment environment
validate_deployment_env() {
  local -r commands_dir="$1"
  local -r flow_dir="$2"
  local -r skills_dir="$3"
  
  local missing=()
  
  [[ -d "$commands_dir" ]] || missing+=("commands: $commands_dir")
  [[ -d "$flow_dir" ]] || missing+=("framework: $flow_dir")
  [[ -d "$skills_dir" ]] || missing+=("skills: $skills_dir")
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    error "Deployment validation failed:"
    for item in "${missing[@]}"; do
      printf "  - %s\n" "$item"
    done
    return 1
  fi
  
  return 0
}

# Validate framework references
validate_framework_refs() {
  local -r commands_file="$1"
  local -r framework_file="$2"
  
  [[ -f "$commands_file" ]] || die "Commands file not found: $commands_file"
  [[ -f "$framework_file" ]] || die "Framework file not found: $framework_file"
  
  local errors=0
  local cmd_count
  cmd_count=$(grep -c "^## /" "$commands_file" 2>/dev/null || echo 0)
  
  info "Validating $cmd_count command definitions"
  
  # Extract command names and validate patterns
  while IFS= read -r line; do
    if [[ "$line" =~ ^##\ /(.+)$ ]]; then
      local cmd="${BASH_REMATCH[1]}"
      
      # Check for framework reading requirements
      if ! grep -A 20 "^## /$cmd$" "$commands_file" | grep -q "🔴 REQUIRED:\|🟢 NO FRAMEWORK READING"; then
        warn "/$cmd: Missing framework reading requirement notice"
        ((errors++))
      fi
    fi
  done < <(grep "^## /" "$commands_file")
  
  [[ $errors -eq 0 ]]
}

# Validate command files exist
validate_command_files() {
  local -r commands_dir="$1"
  local -r commands=("${@:2}")
  
  local missing=()
  
  for cmd in "${commands[@]}"; do
    local cmd_file="${commands_dir}/${cmd}.md"
    [[ -f "$cmd_file" ]] || missing+=("$cmd.md")
  done
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    error "Missing command files:"
    for file in "${missing[@]}"; do
      printf "  - %s\n" "$file"
    done
    return 1
  fi
  
  return 0
}

# Validate skill files exist
validate_skill_files() {
  local -r skills_dir="$1"
  local -r skills=("${@:2}")
  
  local missing=()
  
  for skill in "${skills[@]}"; do
    local skill_file="${skills_dir}/${skill}/SKILL.md"
    [[ -f "$skill_file" ]] || missing+=("$skill/SKILL.md")
  done
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    error "Missing skill files:"
    for file in "${missing[@]}"; do
      printf "  - %s\n" "$file"
    done
    return 1
  fi
  
  return 0
}

# Validate framework content integrity
validate_framework_content() {
  local -r framework_dir="$1"
  
  local required_files=(
    "DEVELOPMENT_FRAMEWORK.md"
    "SLASH_COMMANDS.md"
    "skills/SKILLS_GUIDE.md"
  )
  
  local missing=()
  
  for file in "${required_files[@]}"; do
    [[ -f "${framework_dir}/${file}" ]] || missing+=("$file")
  done
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    error "Missing framework files:"
    for file in "${missing[@]}"; do
      printf "  - %s\n" "$file"
    done
    return 1
  fi
  
  return 0
}

# Comprehensive validation
validate_all() {
  local -r commands_dir="$1"
  local -r flow_dir="$2"
  local -r skills_dir="$3"
  
  header "Validating deployment..."
  
  validate_deployment_env "$commands_dir" "$flow_dir" "$skills_dir" || return 1
  validate_framework_content "$flow_dir/framework" || return 1
  
  success "Validation completed successfully"
  return 0
}