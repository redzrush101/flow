# Flow Framework

**Iterative Design-Driven Development where humans drive, AI executes.**

_You make the decisions. AI implements within your framework. Context is never lost._

[![Version](https://img.shields.io/badge/version-1.4.4-blue.svg)](https://github.com/redzrush101/flow/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](#license)

## What It Is

Flow is **not** AI autopilot. It's **human-in-loop development** that puts you in control while leveraging AI as your execution engine.

**The human drives. The AI executes.**

## Quick Install

```bash
curl -O https://raw.githubusercontent.com/redzrush101/flow/master/flow.sh
chmod +x flow.sh && ./flow.sh
```

## Core Commands

```
/flow-start     # Initialize new project
/flow-plan      # Create/update project plan
/flow-phase     # Manage development phases
/flow-task      # Handle individual tasks
/flow-iterate   # Work through iterations
/flow-brainstorm # Problem-solving sessions
/flow-implement # Execute implementation
/flow-status    # Check project status
/flow-verify    # Validate plan integrity
/flow-compact   # Archive completed work
/flow-backlog   # Manage backlog items
/flow-navigate  # Navigation assistance
```

## How It Works

1. **You design** → Document decisions in `.flow/PLAN.md`
2. **AI implements** → Follows your framework exactly
3. **You verify** → Review and iterate
4. **Context preserved** → Never lost between sessions

### File Structure
```
.flow/
├── DASHBOARD.md     # Your main workspace
├── PLAN.md          # Project overview & decisions
├── phase-1/         # Development phases
│   └── task-1.md   # Task files with iterations
└── framework/       # AI reference files
```

## Why Flow Works

Traditional AI development fails because:
- ❌ **AI decides** architecture → refactoring hell
- ❌ **Context disappears** → AI forgets your design  
- ❌ **No iteration structure** → everything is a rewrite
- ❌ **Decisions lack rationale** → why did we choose this?

Flow fixes this by **putting you in control**:
- ✅ **You design** architecture and make decisions
- ✅ **You define** iterations and scope
- ✅ **AI executes** within your framework
- ✅ **Context preserved** in structured files

## Installation

### Standard Install
```bash
cd your-project/
curl -O https://raw.githubusercontent.com/redzrush101/flow/master/flow.sh
chmod +x flow.sh && ./flow.sh
```

### Force Update
```bash
./flow.sh --force
```

## Usage Example

```bash
# Start a new feature
/flow-start "user-authentication"

# Create comprehensive plan
/flow-plan "build REST API with JWT auth"

# Check current status
/flow-status

# Navigate project structure
/flow-navigate
```

## Framework Philosophy

**Human Responsibilities:**
- Design architecture
- Make technical decisions  
- Define iterations
- Document rationale

**AI Responsibilities:**
- Implement within your framework
- Follow established patterns
- Maintain context between sessions
- Provide execution assistance

## Key Features

- **12 Streamlined Commands** - Essential workflow steps
- **Multi-File Architecture** - Organized, scalable structure
- **Context Preservation** - Never lose design decisions
- **Iteration Management** - Structured development cycles
- **Dashboard-First Navigation** - Clear progress tracking
- **Self-Contained Deployment** - Single script installation

## Tech Specs

- **Language**: Bash
- **Size**: ~3KB (refactored from 18K+ lines)
- **Dependencies**: None (self-contained)
- **Compatibility**: Linux/macOS/WSL
- **License**: MIT

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## License

MIT License - see [LICENSE](LICENSE) file for details.