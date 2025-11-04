#!/usr/bin/env bash

################################################################################
# Flow Framework Deployment Script (Refactored Standalone)
#
# Modular, streamlined deployment system generated from refactored components.
# Version: 1.4.4
# Generated: Tue Nov  4 17:32:58 CET 2025
################################################################################

set -euo pipefail

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Embedded constants from modular components
#!/usr/bin/env bash

# Flow Framework Core Constants (Embedded)
# Version: 1.4.4

# Color definitions
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[1;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_RESET='\033[0m'

# Essential flow commands (consolidated from 27 to 12)
readonly FLOW_COMMANDS=(
  flow-start      # Initialize new project
  flow-plan       # Create/update plan
  flow-phase      # Phase management
  flow-task       # Task management
  flow-iterate    # Iteration workflow
  flow-brainstorm # Brainstorming session
  flow-implement  # Implementation workflow
  flow-status     # Project status
  flow-verify     # Plan verification
  flow-compact    # Compact conversation
  flow-backlog    # Backlog management
  flow-navigate   # Navigation assistance
)

# Framework paths
readonly FRAMEWORK_DIR="${SCRIPT_DIR}/framework"
readonly COMMANDS_DIR="${SCRIPT_DIR}/.claude/commands"
readonly SKILLS_DIR="${SCRIPT_DIR}/.claude/skills"
readonly FLOW_DIR="${SCRIPT_DIR}/.flow"

# File locations
readonly VERSION_FILE="${SCRIPT_DIR}/VERSION"
readonly FRAMEWORK_GUIDE="${FRAMEWORK_DIR}/DEVELOPMENT_FRAMEWORK.md"
readonly COMMANDS_FILE="${FRAMEWORK_DIR}/SLASH_COMMANDS.md"
readonly SKILLS_GUIDE="${FRAMEWORK_DIR}/skills/SKILLS_GUIDE.md"

# Embedded output utilities from modular components  


# Embedded validation utilities from modular components


# Embedded deployment utilities from modular components


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
  if validate_all "$COMMANDS_DIR" "$FLOW_DIR" "$SKILLS_DIR"; then
    separator
    success "Flow Framework deployed successfully!"
    
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

# Execute main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
