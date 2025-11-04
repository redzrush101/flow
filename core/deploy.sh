#!/usr/bin/env bash

# Flow Framework Deployment Utilities
# Handles framework installation and content deployment

# Deploy command files
deploy_commands() {
  local -r source_dir="$1"
  local -r target_dir="$2"
  local -r force="${3:-false}"
  
  [[ -d "$source_dir" ]] || die "Source commands directory not found: $source_dir"
  
  mkdir -p "$target_dir"
  
  local count=0
  local skipped=0
  
  for cmd_file in "$source_dir"/*.md; do
    [[ -f "$cmd_file" ]] || continue
    
    local cmd_name=$(basename "$cmd_file" .md)
    local target_file="${target_dir}/${cmd_name}.md"
    
    if [[ -f "$target_file" && "$force" != "true" ]]; then
      ((skipped++))
      continue
    fi
    
    cp "$cmd_file" "$target_file"
    ((count++))
  done
  
  info "Deployed $count command files"
  [[ $skipped -gt 0 ]] && info "Skipped $skipped existing files"
  
  return 0
}

# Deploy framework documentation
deploy_framework() {
  local -r source_dir="$1"
  local -r target_dir="$2"
  local -r force="${3:-false}"
  
  [[ -d "$source_dir" ]] || die "Source framework directory not found: $source_dir"
  
  mkdir -p "$target_dir/framework"
  
  local count=0
  
  # Copy main framework files
  for file in "$source_dir"/*.md; do
    [[ -f "$file" ]] || continue
    
    local basename_file=$(basename "$file")
    local target_file="${target_dir}/framework/${basename_file}"
    
    if [[ -f "$target_file" && "$force" != "true" ]]; then
      continue
    fi
    
    cp "$file" "$target_file"
    ((count++))
  done
  
  # Copy skills directory
  if [[ -d "$source_dir/skills" ]]; then
    cp -r "$source_dir/skills" "${target_dir}/framework/"
    ((count++))
  fi
  
  # Copy examples directory
  if [[ -d "$source_dir/examples" ]]; then
    cp -r "$source_dir/examples" "${target_dir}/framework/"
    ((count++))
  fi
  
  info "Deployed $count framework components"
  return 0
}

# Deploy skill files
deploy_skills() {
  local -r source_dir="$1"
  local -r target_dir="$2"
  local -r force="${3:-false}"
  
  [[ -d "$source_dir" ]] || die "Source skills directory not found: $source_dir"
  
  mkdir -p "$target_dir"
  
  local count=0
  
  for skill_dir in "$source_dir"/*; do
    [[ -d "$skill_dir" ]] || continue
    
    local skill_name=$(basename "$skill_dir")
    local target_skill_dir="${target_dir}/${skill_name}"
    
    if [[ -d "$target_skill_dir" && "$force" != "true" ]]; then
      continue
    fi
    
    cp -r "$skill_dir" "$target_skill_dir"
    ((count++))
  done
  
  info "Deployed $count skill directories"
  return 0
}

# Update CLAUDE.md with framework information
update_claude_md() {
  local -r flow_dir="$1"
  local -r force="${2:-false}"
  
  local claude_file="${flow_dir}/../CLAUDE.md"
  
  if [[ -f "$claude_file" && "$force" != "true" ]]; then
    info "CLAUDE.md already exists, skipping update"
    return 0
  fi
  
  cat > "$claude_file" << 'EOF'
# Flow Framework

This project uses the Flow framework for AI-assisted development workflow management.

## Quick Start

1. Use `/flow-start <feature-name>` to initialize a new feature development
2. Use `/flow-status` to check current project status
3. Use `/flow-navigate` for dashboard-first navigation guidance

## Framework Files

- `.flow/framework/DEVELOPMENT_FRAMEWORK.md` - Complete methodology guide
- `.flow/framework/skills/SKILLS_GUIDE.md` - Agent skills documentation
- `.flow/framework/examples/` - Reference implementation examples

## Workflow Commands

- `/flow-plan` - Create or update project plans
- `/flow-phase` - Manage development phases
- `/flow-task` - Handle individual tasks
- `/flow-iterate` - Work through iterations
- `/flow-brainstorm` - Conduct brainstorming sessions
- `/flow-implement` - Execute implementation phases
- `/flow-verify` - Verify plan integrity
- `/flow-compact` - Compact conversation history
- `/flow-backlog` - Manage backlog items

For detailed usage, refer to the framework documentation in `.flow/framework/`.
EOF

  success "Updated CLAUDE.md"
  return 0
}