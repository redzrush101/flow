#!/usr/bin/env bash

# Flow Framework Core Constants
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