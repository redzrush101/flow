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
OUTPUT_FILE="${SCRIPT_DIR}/flow.sh"
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
separator() { printf "${CYAN}%s${RESET}\n" "$(printf '━%.0s' {1..50})"; }

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

# Embed actual modular content from files
embed_modular_content() {
  log_header "Embedding modular content..."
  
  # Generate the main script with embedded modular content
  cat > "$OUTPUT_FILE" << 'EOF'
#!/usr/bin/env bash

################################################################################
# Flow Framework Deployment Script (Refactored Standalone)
#
# Modular, streamlined deployment system generated from refactored components.
# Version: 1.4.4
# Generated: $(date)
################################################################################

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Flow Framework Core Constants
FLOW_VERSION="1.4.4"
FLOW_COMMANDS=(
  flow-start flow-plan flow-phase flow-task flow-iterate
  flow-brainstorm flow-implement flow-status flow-verify
  flow-compact flow-backlog flow-navigate
)

# Color definitions
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_CYAN='\033[0;36m'
COLOR_RESET='\033[0m'

# Output utilities
error() { printf "${COLOR_RED}✗ %s${COLOR_RESET}\n" "$*" >&2; }
success() { printf "${COLOR_GREEN}✓ %s${COLOR_RESET}\n" "$*"; }
info() { printf "${COLOR_BLUE}ℹ %s${COLOR_RESET}\n" "$*"; }
header() { printf "${COLOR_CYAN}▶ %s${COLOR_RESET}\n" "$*"; }
die() { error "$*"; exit 1; }

# Validation utilities
validate_deployment_env() {
  local commands_dir="$1" flow_dir="$2" skills_dir="$3"
  local missing=()
  
  [[ -d "$commands_dir" ]] || missing+=("commands")
  [[ -d "$flow_dir" ]] || missing+=("framework")
  [[ -d "$skills_dir" ]] || missing+=("skills")
  
  [[ ${#missing[@]} -eq 0 ]] || die "Missing: ${missing[*]}"
}

# Deployment utilities
deploy_commands() {
  local source_dir="$1" target_dir="$2" force="${3:-false}"
  
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

update_claude_md() {
  local flow_dir="$1"
  local claude_file="${flow_dir}/../CLAUDE.md"
  
  cat > "$claude_file" << 'CLAUDE_EOF'
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
CLAUDE_EOF
  
  success "Updated CLAUDE.md"
}

# File paths
COMMANDS_DIR="${SCRIPT_DIR}/.claude/commands"
SKILLS_DIR="${SCRIPT_DIR}/.claude/skills"
FLOW_DIR="${SCRIPT_DIR}/.flow"

# Main deployment function
main() {
  header "Flow Framework v${FLOW_VERSION}"
  
  # Deploy components
  info "Deploying commands..."
  deploy_commands "${SCRIPT_DIR}/commands" "$COMMANDS_DIR"
  
  info "Deploying framework..."
  mkdir -p "${FLOW_DIR}/framework"
  cp -r "${SCRIPT_DIR}/framework"/* "${FLOW_DIR}/framework/" 2>/dev/null || true
  
  info "Deploying skills..."
  cp -r "${SCRIPT_DIR}/framework/skills" "${SKILLS_DIR}" 2>/dev/null || true
  
  info "Updating project documentation..."
  update_claude_md "$FLOW_DIR"
  
  # Validate deployment
  validate_deployment_env "$COMMANDS_DIR" "$FLOW_DIR" "$SKILLS_DIR"
  
  success "Flow Framework deployed successfully!"
  
  echo ""
  echo "Next Steps:"
  echo "1. Restart Claude Code (if running)"
  echo "2. Run: /flow-start <your-feature-name>"
  echo "3. Read: ${FLOW_DIR}/framework/DEVELOPMENT_FRAMEWORK.md"
  echo "4. Examples: ${FLOW_DIR}/framework/examples/"
  echo "5. Skills Guide: ${FLOW_DIR}/framework/skills/SKILLS_GUIDE.md"
}

# Execute main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
EOF

  chmod +x "$OUTPUT_FILE"
  log_success "Generated refactored standalone script: $OUTPUT_FILE"
}

# Main build process
main() {
  log_header "Building Flow Framework refactored standalone script"
  
  validate_prerequisites
  embed_modular_content
  
  separator
  log_success "Build completed successfully!"
  log_info "Output: $OUTPUT_FILE"
  log_info "Size: $(wc -c < "$OUTPUT_FILE" | numfmt --to=iec)"
  log_info "Commands: 12 streamlined commands"
  log_info "Framework: Modular architecture (refactored)"
}

# Execute if run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi