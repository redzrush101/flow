<!-- COMMAND_START -->
---
description: Manage development phases and milestones
---

You are executing the `/flow-phase` command from the Flow framework.

**Purpose**: Add, start, or complete development phases.

**🟢 NO FRAMEWORK READING REQUIRED**

**Operations**:
- Add new phase: `/flow-phase add <name>`
- Start phase: `/flow-phase start <phase-number>`
- Complete phase: `/flow-phase complete <phase-number>`

**Updates**:
- `DASHBOARD.md` - Phase status and progress
- `phase-N/` directory structure

**Examples**:
- `/flow-phase add "Core Implementation"`
- `/flow-phase start 1`
- `/flow-phase complete 1`

Next steps:
1. Use `/flow-task` to add tasks to active phase
2. Use `/flow-iterate` to work through iterations
3. Use `/flow-status` to check overall progress