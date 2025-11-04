#!/usr/bin/env bash

################################################################################
# Flow Framework Deployment Script (Refactored)
#
# Modular, streamlined deployment system for the Flow framework.
# Consolidated from 18,315 lines to ~500 lines while maintaining 100% feature parity.
#
# Version: 1.4.4
################################################################################

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source core modules
source "${SCRIPT_DIR}/core/constants.sh"
source "${SCRIPT_DIR}/core/output.sh"
source "${SCRIPT_DIR}/core/validation.sh"
source "${SCRIPT_DIR}/core/deploy.sh"

# Read version from VERSION file
FLOW_VERSION=$(cat "$VERSION_FILE" 2>/dev/null || echo "1.4.4")
FORCE=false

# Print help information
print_help() {
  cat << EOF
Flow Framework Deployment Script v${FLOW_VERSION}

USAGE:
  ./flow.sh [OPTIONS]

OPTIONS:
  -h, --help          Show this help message
  -f, --force         Force overwrite existing files
  -v, --validate      Validate framework installation
  --version           Show version information

DESCRIPTION:
  Deploys the Flow framework including slash commands, agent skills,
  and framework documentation to your project.

EXAMPLES:
  ./flow.sh                    # Standard deployment
  ./flow.sh --force            # Force overwrite existing files
  ./flow.sh --validate         # Validate existing installation
  ./flow.sh -h                 # Show help

FRAMEWORK STRUCTURE:
  .claude/commands/       (${#FLOW_COMMANDS[@]} slash commands)
  .claude/skills/         (8 Agent Skills)
  .flow/                  (your workspace)
    └── framework/        (AI reference files)

For more information, see: ${FRAMEWORK_GUIDE}
EOF
}

# Parse command line arguments
parse_args() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -h|--help)
        print_help
        exit 0
        ;;
      -f|--force)
        FORCE=true
        shift
        ;;
      -v|--validate)
        validate_existing_installation
        exit $?
        ;;
      --version)
        echo "Flow Framework v${FLOW_VERSION}"
        exit 0
        ;;
      *)
        error "Unknown option: $1"
        print_help
        exit 1
        ;;
    esac
  done
}

# Validate existing installation
validate_existing_installation() {
  header "Validating existing Flow framework installation..."
  
  if [[ ! -d "$COMMANDS_DIR" || ! -d "$SKILLS_DIR" || ! -d "$FLOW_DIR" ]]; then
    error "Flow framework not properly installed"
    info "Run: ./flow.sh to install the framework"
    return 1
  fi
  
  validate_all "$COMMANDS_DIR" "$FLOW_DIR" "$SKILLS_DIR"
}

# Main deployment function
main() {
  header "Flow Framework Deployment v${FLOW_VERSION}"
  separator
  
  # Validate prerequisites
  validate_commands mkdir cp grep find
  
  # Deploy components
  info "Deploying slash commands..."
  deploy_commands "$FRAMEWORK_DIR" "$COMMANDS_DIR" "$FORCE"
  
  info "Deploying framework documentation..."
  deploy_framework "$FRAMEWORK_DIR" "$FLOW_DIR" "$FORCE"
  
  info "Deploying agent skills..."
  deploy_skills "${FRAMEWORK_DIR}/skills" "$SKILLS_DIR" "$FORCE"
  
  info "Updating project documentation..."
  update_claude_md "$FLOW_DIR" "$FORCE"
  
  # Validate deployment
  if validate_all "$COMMANDS_DIR" "$FLOW_DIR" "$SKILLS_DIR"; then
    separator
    success "Flow Framework installed successfully!"
    
    header "Next Steps:"
    info "1. Restart Claude Code (if running)"
    info "2. Run: /flow-start <your-feature-name>"
    info "3. Read: ${FLOW_DIR}/framework/DEVELOPMENT_FRAMEWORK.md"
    info "4. Examples: ${FLOW_DIR}/framework/examples/"
    info "5. Skills Guide: ${FLOW_DIR}/framework/skills/SKILLS_GUIDE.md"
  else
    error "Deployment validation failed"
    return 1
  fi
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  parse_args "$@"
  main
fi