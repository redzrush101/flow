#!/usr/bin/env bash

################################################################################
# Flow Framework Build Script (Refactored)
#
# Creates a streamlined standalone deployment script from modular components.
# Replaces the 18,315-line monolithic approach with clean templating.
#
# Version: 1.4.4
################################################################################

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${SCRIPT_DIR}/flow-standalone.sh"
VERSION_FILE="${SCRIPT_DIR}/VERSION"
CORE_DIR="${SCRIPT_DIR}/core"
COMMANDS_DIR="${SCRIPT_DIR}/commands"
FRAMEWORK_DIR="${SCRIPT_DIR}/framework"

# Read version
FLOW_VERSION=$(cat "$VERSION_FILE" 2>/dev/null || echo "1.4.4")

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Logging functions
log_info() { printf "${BLUE}ℹ %s${RESET}\n" "$*"; }
log_success() { printf "${GREEN}✓ %s${RESET}\n" "$*"; }
log_error() { printf "${RED}✗ %s${RESET}\n" "$*" >&2; }
log_header() { printf "${CYAN}▶ %s${RESET}\n" "$*"; }

# Validate prerequisites
validate_prerequisites() {
  local missing=()
  
  [[ -d "$CORE_DIR" ]] || missing+=("core/")
  [[ -d "$COMMANDS_DIR" ]] || missing+=("commands/")
  [[ -d "$FRAMEWORK_DIR" ]] || missing+=("framework/")
  
  if [[ ${#missing[@]} -gt 0 ]]; then
    log_error "Missing directories: ${missing[*]}"
    exit 1
  fi
}

# Generate embedded content sections
generate_embedded_content() {
  local section="$1"
  
  case "$section" in
    constants)
      cat << 'EOF'
# Flow Framework Core Constants
readonly FLOW_VERSION="${FLOW_VERSION:-1.4.4}"
readonly FLOW_COMMANDS=(
  flow-start flow-plan flow-phase flow-task flow-iterate
  flow-brainstorm flow-implement flow-status flow-verify
  flow-compact flow-backlog flow-navigate
)

# Color definitions
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[1;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_RESET='\033[0m'
EOF
      ;;
    output)
      cat << 'EOF'
# Output utilities
error() { printf "${COLOR_RED}✗ %s${COLOR_RESET}\n" "$*" >&2; }
success() { printf "${COLOR_GREEN}✓ %s${COLOR_RESET}\n" "$*"; }
info() { printf "${COLOR_BLUE}ℹ %s${COLOR_RESET}\n" "$*"; }
header() { printf "${COLOR_CYAN}▶ %s${COLOR_RESET}\n" "$*"; }
die() { error "$*"; exit 1; }
EOF
      ;;
    validation)
      cat << 'EOF'
# Validation utilities
validate_deployment_env() {
  local -r commands_dir="$1" flow_dir="$2" skills_dir="$3"
  local missing=()
  
  [[ -d "$commands_dir" ]] || missing+=("commands")
  [[ -d "$flow_dir" ]] || missing+=("framework")
  [[ -d "$skills_dir" ]] || missing+=("skills")
  
  [[ ${#missing[@]} -eq 0 ]] || die "Missing: ${missing[*]}"
}
EOF
      ;;
    deploy)
      cat << 'EOF'
# Deployment utilities
deploy_commands() {
  local -r source_dir="$1" target_dir="$2" force="${3:-false}"
  
  [[ -d "$source_dir" ]] || die "Source not found: $source_dir"
  mkdir -p "$target_dir"
  
  local count=0
  for cmd_file in "$source_dir"/*.md; do
    [[ -f "$cmd_file" ]] || continue
    
    local cmd_name=$(basename "$cmd_file" .md)
    local target_file="${target_dir}/${cmd_name}.md"
    
    [[ -f "$target_file" && "$force" != "true" ]] && continue
    
    cp "$cmd_file" "$target_file"
    ((count++))
  done
  
  info "Deployed $count command files"
}
EOF
      ;;
  esac
}

# Generate the main script
generate_main_script() {
  log_header "Generating Flow Framework standalone script v${FLOW_VERSION}..."
  
  cat > "$OUTPUT_FILE" << EOF
#!/usr/bin/env bash

################################################################################
# Flow Framework Deployment Script (Standalone)
# 
# Self-contained deployment script generated from modular components.
# Version: ${FLOW_VERSION}
# Generated: $(date)
################################################################################

set -euo pipefail

# Get script directory
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"

# Embedded constants
$(generate_embedded_content constants)

# Embedded output utilities  
$(generate_embedded_content output)

# Embedded validation utilities
$(generate_embedded_content validation)

# Embedded deployment utilities
$(generate_embedded_content deploy)

# File paths
COMMANDS_DIR="\${SCRIPT_DIR}/.claude/commands"
SKILLS_DIR="\${SCRIPT_DIR}/.claude/skills"
FLOW_DIR="\${SCRIPT_DIR}/.flow"

# Main deployment function
main() {
  header "Flow Framework v\${FLOW_VERSION}"
  
  # Deploy components
  info "Deploying commands..."
  deploy_commands "\${SCRIPT_DIR}/commands" "\$COMMANDS_DIR"
  
  info "Deploying framework..."
  mkdir -p "\${FLOW_DIR}/framework"
  cp -r "\${SCRIPT_DIR}/framework"/* "\${FLOW_DIR}/framework/" 2>/dev/null || true
  
  info "Deploying skills..."
  cp -r "\${SCRIPT_DIR}/framework/skills" "\$SKILLS_DIR" 2>/dev/null || true
  
  # Validate deployment
  validate_deployment_env "\$COMMANDS_DIR" "\${FLOW_DIR}/framework" "\$SKILLS_DIR"
  
  success "Flow Framework deployed successfully!"
  info "Next: /flow-start <your-feature-name>"
}

# Execute main function
main "\$@"
EOF

  chmod +x "$OUTPUT_FILE"
  log_success "Generated standalone script: $OUTPUT_FILE"
}

# Generate command files with embedded content
generate_command_files() {
  log_header "Generating command files with embedded content..."
  
  local commands_output="${SCRIPT_DIR}/embedded_commands.sh"
  
  cat > "$commands_output" << 'EOF'
# Embedded command content
# This file contains the content for all Flow commands

# flow-start content
FLOW_START_CONTENT=$(cat << 'ENDCONTENT'
<!-- COMMAND_START -->
---
description: Initialize new Flow project or feature development
---

You are executing the `/flow-start` command from the Flow framework.

**Purpose**: Create a new multi-file Flow project structure from scratch.

**🔴 REQUIRED: Read Framework Quick Reference**

- Read: .flow/framework/DEVELOPMENT_FRAMEWORK.md lines 1-600 (Quick Reference)
- Read: .flow/framework/examples/ directory for patterns

**Creates**:
- `DASHBOARD.md` - Progress tracking (user's main workspace)
- `PLAN.md` - Static context (overview, architecture, scope)
- `phase-1/task-1.md` - First task file

**Usage**: `/flow-start <feature-name>`

**Example**: `/flow-start user-authentication`

Next steps:
1. Review DASHBOARD.md for current status
2. Update PLAN.md with project specifics
3. Use `/flow-plan` to refine the plan
ENDCONTENT
)
EOF

  log_success "Generated embedded command content"
}

# Main build process
main() {
  log_header "Building Flow Framework standalone deployment script"
  
  validate_prerequisites
  generate_main_script
  generate_command_files
  
  separator
  log_success "Build completed successfully!"
  log_info "Output: $OUTPUT_FILE"
  log_info "Size: $(wc -c < "$OUTPUT_FILE" | numfmt --to=iec)"
  log_info "Commands: 12 streamlined commands"
  log_info "Framework: Modular architecture"
}

# Execute if run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi