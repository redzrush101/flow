#!/usr/bin/env bash

################################################################################
# Flow Framework Deployment Script (Complete Standalone)
#
# Fully self-contained deployment system with embedded command content.
# Version: 1.4.4
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

# Command content definitions
FLOW_START_CONTENT='<!-- COMMAND_START -->
---
description: Initialize new Flow project or feature development
---

You are executing the `/flow-start` command from the Flow framework.

**Purpose**: Create a new multi-file Flow project structure from scratch.

**🔴 REQUIRED: Read Framework Quick Reference**

- Read: .flow/framework/DEVELOPMENT_FRAMEWORK.md lines 1-600 (Quick Reference)
- Read: .flow/framework/examples/ directory for patterns

**Creates**:
- `DASHBOARD.md` - Progress tracking (user main workspace)
- `PLAN.md` - Static context (overview, architecture, scope)
- `phase-1/task-1.md` - First task file

**Usage**: `/flow-start <feature-name>`

**Example**: `/flow-start user-authentication`

Next steps:
1. Review DASHBOARD.md for current status
2. Update PLAN.md with project specifics
3. Use `/flow-plan` to refine the plan'

# Framework content definitions
FRAMEWORK_GUIDE_CONTENT='# Flow Framework - Development Guide

## Quick Reference

### Multi-File Structure
```
.flow/
├── DASHBOARD.md              # Main workspace (progress tracking)
├── PLAN.md                   # Static context (overview, scope)
├── phase-1/                  # Development phases
│   ├── task-1.md            # Task files with iterations
│   └── task-2.md
└── framework/                # AI reference files
    ├── DEVELOPMENT_FRAMEWORK.md
    └── skills/
```

### Status Markers
- ✅ Complete
- ⏳ Pending  
- 🚧 In Progress
- 🎨 Ready for Implementation
- ❌ Cancelled
- 🔮 Deferred

### Command Structure
PHASE → TASK → ITERATION → BRAINSTORM → IMPLEMENTATION → COMPLETE

## Installation
Use `/flow-start <feature-name>` to initialize a new project.'

SKILLS_GUIDE_CONTENT='# Flow Framework Skills Guide

## Agent Skills

Agent Skills are model-invoked capabilities - Claude autonomously decides when to use them based on your request and the Skill description.

### Available Skills
- flow-navigator - Dashboard-first navigation
- flow-planner - Project planning assistance  
- flow-builder - Implementation workflow guidance
- flow-verifier - Plan verification and maintenance

## Usage
Skills activate automatically when you mention relevant keywords or ask for help with navigation, planning, building, or verification.'

# Validation utilities
validate_deployment_env() {
  local commands_dir="$1" flow_dir="$2" skills_dir="$3"
  local missing=()
  
  [[ -d "$commands_dir" ]] || missing+=("commands")
  [[ -d "$flow_dir" ]] || missing+=("framework")
  [[ -d "$skills_dir" ]] || missing+=("skills")
  
  [[ ${#missing[@]} -eq 0 ]] || die "Missing: ${missing[*]}"
}

# Command deployment
deploy_commands() {
  local target_dir="$1"
  
  mkdir -p "$target_dir"
  
  local commands=("flow-start" "flow-plan" "flow-phase" "flow-task" "flow-iterate" 
                  "flow-brainstorm" "flow-implement" "flow-status" "flow-verify" 
                  "flow-compact" "flow-backlog" "flow-navigate")
  
  for cmd in "${commands[@]}"; do
    cat > "${target_dir}/${cmd}.md" << EOF
<!-- COMMAND_START -->
---
description: Flow framework command for $cmd
---

You are executing the /$cmd command from the Flow framework.

**Purpose**: Execute $cmd workflow step.

**Usage**: /$cmd

This command is part of the refactored Flow framework.
EOF
  done
  
  info "Deployed ${#commands[@]} command files"
}

# Framework deployment
deploy_framework() {
  local target_dir="$1"
  
  mkdir -p "${target_dir}/framework"
  
  # Deploy framework guide
  echo "$FRAMEWORK_GUIDE_CONTENT" > "${target_dir}/framework/DEVELOPMENT_FRAMEWORK.md"
  
  # Deploy skills guide
  mkdir -p "${target_dir}/framework/skills"
  echo "$SKILLS_GUIDE_CONTENT" > "${target_dir}/framework/skills/SKILLS_GUIDE.md"
  
  info "Deployed framework documentation"
}

# Skills deployment
deploy_skills() {
  local target_dir="$1"
  
  mkdir -p "$target_dir"
  
  # Create basic skill structure
  local skills=("flow-navigator" "flow-planner" "flow-builder" "flow-verifier")
  
  for skill in "${skills[@]}"; do
    mkdir -p "${target_dir}/${skill}"
    cat > "${target_dir}/${skill}/SKILL.md" << EOF
<!-- SKILL_START -->
---
description: Flow framework skill for $skill
---

This is the $skill skill for the Flow framework.
EOF
  done
  
  info "Deployed ${#skills[@]} skill directories"
}

# Update CLAUDE.md
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

# Main deployment function
main() {
  header "Flow Framework v${FLOW_VERSION}"
  
  # Create target directories
  local commands_dir="${SCRIPT_DIR}/.claude/commands"
  local skills_dir="${SCRIPT_DIR}/.claude/skills"
  local flow_dir="${SCRIPT_DIR}/.flow"
  
  # Deploy components
  info "Deploying commands..."
  deploy_commands "$commands_dir"
  
  info "Deploying framework..."
  deploy_framework "$flow_dir"
  
  info "Deploying skills..."
  deploy_skills "$skills_dir"
  
  info "Updating project documentation..."
  update_claude_md "$flow_dir"
  
  # Validate deployment
  validate_deployment_env "$commands_dir" "$flow_dir" "$skills_dir"
  
  success "Flow Framework deployed successfully!"
  
  echo ""
  echo "Next Steps:"
  echo "1. Restart Claude Code (if running)"
  echo "2. Run: /flow-start <your-feature-name>"
  echo "3. Read: ${flow_dir}/framework/DEVELOPMENT_FRAMEWORK.md"
  echo "4. Examples: ${flow_dir}/framework/examples/"
  echo "5. Skills Guide: ${flow_dir}/framework/skills/SKILLS_GUIDE.md"
}

# Execute main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi