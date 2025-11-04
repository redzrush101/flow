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