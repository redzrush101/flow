# Flow Framework - Streamlined Slash Commands

This file contains the essential slash command definitions for the Flow framework.

---

## Command Guidelines

**IMPORTANT**: Every command must:

1. **Read the framework guide** at the start to understand patterns
2. **Find and parse .flow/PLAN.md** to understand current state  
3. **Follow framework patterns exactly** (status markers, section structure)
4. **Update .flow/PLAN.md** according to framework conventions
5. **Provide clear next steps** to the user

**Status Markers**:
- ✅ Complete
- ⏳ Pending
- 🚧 In Progress
- 🎨 Ready for Implementation
- ❌ Cancelled
- 🔮 Deferred

---

## /flow-start

**File**: `flow-start.md`

```markdown
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

Next steps:
1. Review DASHBOARD.md for current status
2. Update PLAN.md with project specifics
3. Use `/flow-plan` to refine the plan
```

---

## /flow-plan

**File**: `flow-plan.md`

```markdown
<!-- COMMAND_START -->
---
description: Create or update project plan and architecture
---

You are executing the `/flow-plan` command from the Flow framework.

**Purpose**: Create comprehensive project plan with phases, tasks, and iterations.

**🟢 NO FRAMEWORK READING REQUIRED**

**Updates**:
- `PLAN.md` - Project overview, goals, scope, architecture
- `DASHBOARD.md` - Progress tracking with all phases/tasks

**Process**:
1. Analyze current project state from DASHBOARD.md
2. Define clear project phases and milestones
3. Break down into specific tasks with iterations
4. Establish architecture and technical decisions

Next steps:
1. Review updated PLAN.md
2. Use `/flow-phase` to begin first phase
3. Use `/flow-task` to start specific tasks
```

---

## /flow-phase

**File**: `flow-phase.md`

```markdown
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

Next steps:
1. Use `/flow-task` to add tasks to active phase
2. Use `/flow-iterate` to work through iterations
3. Use `/flow-status` to check overall progress
```

---

## /flow-task

**File**: `flow-task.md`

```markdown
<!-- COMMAND_START -->
---
description: Manage individual tasks within phases
---

You are executing the `/flow-task` command from the Flow framework.

**Purpose**: Add, start, or complete tasks within phases.

**🟢 NO FRAMEWORK READING REQUIRED**

**Operations**:
- Add task: `/flow-task add <name>`
- Start task: `/flow-task start <task-number>`
- Complete task: `/flow-task complete <task-number>`

**Updates**:
- `DASHBOARD.md` - Task status tracking
- `phase-N/task-N.md` - Task-specific files

Next steps:
1. Use `/flow-iterate` to begin iterations
2. Use `/flow-brainstorm` for problem-solving
3. Use `/flow-implement` for coding tasks
```

---

## /flow-iterate

**File**: `flow-iterate.md`

```markdown
<!-- COMMAND_START -->
---
description: Work through task iterations with brainstorming and implementation
---

You are executing the `/flow-iterate` command from the Flow framework.

**Purpose**: Manage iterations within tasks (brainstorm → implement → complete).

**🟢 NO FRAMEWORK READING REQUIRED**

**Process**:
1. Add iteration: `/flow-iterate add <description>`
2. Start brainstorming: `/flow-iterate brainstorm`
3. Begin implementation: `/flow-iterate implement`
4. Complete iteration: `/flow-iterate complete`

**Updates**:
- `phase-N/task-N.md` - Iteration details and progress
- `DASHBOARD.md` - Current iteration tracking

Next steps:
1. Use `/flow-brainstorm` for detailed brainstorming
2. Use `/flow-implement` for focused implementation
3. Use `/flow-status` to track progress
```

---

## /flow-brainstorm

**File**: `flow-brainstorm.md`

```markdown
<!-- COMMAND_START -->
---
description: Conduct brainstorming sessions for problem-solving and architecture
---

You are executing the `/flow-brainstorm` command from the Flow framework.

**Purpose**: Structured brainstorming for technical decisions and solutions.

**🟢 NO FRAMEWORK READING REQUIRED**

**Process**:
1. Start session: `/flow-brainstorm start`
2. Add subjects: `/flow-brainstorm subject <topic>`
3. Review subjects: `/flow-brainstorm review`
4. Complete session: `/flow-brainstorm complete`

**Updates**:
- `phase-N/task-N.md` - Brainstorming subjects and resolutions
- Consolidates decisions into actionable items

Next steps:
1. Use `/flow-implement` to act on decisions
2. Use `/flow-verify` to validate approach
3. Continue with next iteration
```

---

## /flow-implement

**File**: `flow-implement.md`

```markdown
<!-- COMMAND_START -->
---
description: Execute implementation phases with code and testing
---

You are executing the `/flow-implement` command from the Flow framework.

**Purpose**: Execute implementation based on brainstorming decisions.

**🟢 NO FRAMEWORK READING REQUIRED**

**Process**:
1. Start implementation: `/flow-implement start`
2. Execute code changes
3. Complete implementation: `/flow-implement complete`

**Updates**:
- `phase-N/task-N.md` - Implementation details and results
- Code files and project structure

Next steps:
1. Use `/flow-verify` to validate implementation
2. Use `/flow-status` to update progress
3. Move to next iteration or task
```

---

## /flow-status

**File**: `flow-status.md`

```markdown
<!-- COMMAND_START -->
---
description: Display current project status and progress overview
---

You are executing the `/flow-status` command from the Flow framework.

**Purpose**: Show comprehensive project status and navigation guidance.

**🟢 NO FRAMEWORK READING REQUIRED**

**Displays**:
- Current phase, task, iteration
- Progress overview with status markers
- Next recommended actions
- Key decisions and blockers

**Reads**:
- `DASHBOARD.md` - Current state
- `PLAN.md` - Project overview
- `phase-N/task-N.md` - Active task details

Next steps:
1. Follow recommended next actions
2. Use `/flow-navigate` for detailed guidance
3. Update plan if needed with `/flow-plan`
```

---

## /flow-verify

**File**: `flow-verify.md`

```markdown
<!-- COMMAND_START -->
---
description: Verify plan integrity and validate implementation
---

You are executing the `/flow-verify` command from the Flow framework.

**Purpose**: Validate plan structure and check implementation correctness.

**🟢 NO FRAMEWORK READING REQUIRED**

**Validates**:
- Plan structure and consistency
- Status marker usage
- File organization
- Implementation completeness

**Checks**:
- `DASHBOARD.md` - Progress tracking
- `PLAN.md` - Project overview
- `phase-N/task-N.md` - Task files

**Fixes**:
- Inconsistent status markers
- Missing sections
- Broken references

Next steps:
1. Review verification results
2. Fix any identified issues
3. Continue with workflow
```

---

## /flow-compact

**File**: `flow-compact.md`

```markdown
<!-- COMMAND_START -->
---
description: Compact conversation history and archive completed work
---

You are executing the `/flow-compact` command from the Flow framework.

**Purpose**: Archive completed work and maintain clean project structure.

**🟢 NO FRAMEWORK READING REQUIRED**

**Actions**:
- Archive completed phases/tasks to BACKLOG.md
- Remove redundant conversation history
- Maintain clean DASHBOARD.md
- Create ARCHIVE.md for completed work

**Updates**:
- `BACKLOG.md` - Deferred/future items
- `ARCHIVE.md` - Completed work history
- `DASHBOARD.md` - Clean current state

Next steps:
1. Review archived content
2. Continue with active work
3. Use `/flow-status` to verify clean state
```

---

## /flow-backlog

**File**: `flow-backlog.md`

```markdown
<!-- COMMAND_START -->
---
description: Manage backlog items and deferred features
---

You are executing the `/flow-backlog` command from the Flow framework.

**Purpose**: Manage deferred tasks and future feature planning.

**🟢 NO FRAMEWORK READING REQUIRED**

**Operations**:
- Add item: `/flow-backlog add <description>`
- View backlog: `/flow-backlog view`
- Pull item: `/flow-backlog pull <item-number>`

**Manages**:
- `BACKLOG.md` - Deferred features and tasks
- V2/V3 planning items
- Future enhancements

Next steps:
1. Review backlog regularly
2. Pull items when ready to implement
3. Use `/flow-plan` to integrate backlog items
```

---

## /flow-navigate

**File**: `flow-navigate.md`

```markdown
<!-- COMMAND_START -->
---
description: Navigate Flow framework's multi-file architecture
---

You are executing the `/flow-navigate` command from the Flow framework.

**Purpose**: Provide dashboard-first navigation guidance for project structure.

**🟢 NO FRAMEWORK READING REQUIRED**

**Provides**:
- Current work location (Phase/Task/Iteration)
- File structure overview
- Navigation recommendations
- Next action suggestions

**Reads**:
- `DASHBOARD.md` - Current state
- `PLAN.md` - Project overview
- Active task files

**Usage**: When user asks "where am I", "what's next", "show status"

Next steps:
1. Follow navigation recommendations
2. Use specific commands for actions
3. Check `/flow-status` for detailed progress
```