# MVPKit Module

MVPKit is a BMAD module that provides an AI-guided curriculum for teaching non-technical founders to build real, shippable products.

## Overview

MVPKit teaches product development through four complete app builds:
1. **Calendly Clone** - Scheduling and booking
2. **ChatGPT Clone** - AI chat application
3. **Intercom Clone** - Customer support with AI
4. **Gumroad Clone** - Digital product sales

Students learn by building, with an AI tutor (Kit) guiding them through each step.

## Module Structure

```
.bmad/mvpkit/
├── agents/
│   └── mvpkit-tutor/           # Kit - the AI tutor
│       ├── mvpkit-tutor.agent.yaml
│       └── mvpkit-tutor-sidecar/
│           ├── memories.md     # Student progress tracking
│           ├── instructions.md # Teaching protocols
│           └── knowledge/      # Tech stack reference
│
├── workflows/
│   └── foundations/
│       └── 01-setup/           # First lesson
│           ├── workflow.md
│           ├── steps/          # 6 sequential steps
│           ├── templates/      # Progress template
│           └── checkpoint.yaml # Validation schema
│
└── docs/
    └── README.md               # This file
```

## The MVPKit Tutor (Kit)

Kit is an Expert agent that:
- Maintains persistent memory of student progress
- Guides students through lessons with patience
- Validates checkpoints before allowing progression
- Adapts explanations to student's level
- Celebrates wins and helps through struggles

### Tutor Commands

| Command | Action |
|---------|--------|
| `start` | Begin or resume current lesson |
| `check` | Validate work for current step |
| `help` | Get assistance when stuck |
| `explain` | Deeper dive on current concept |
| `next` | Continue to next step (after checkpoint) |
| `progress` | Show overall course progress |
| `save` | Save session progress |

## Curriculum Structure

### Foundations (Required)
1. **01-Setup** - Development environment and tools
2. **02-How Apps Work** - Frontend/backend mental model
3. **03-Working With AI** - Prompting and validation
4. **04-Writing Specs** - Product definition skills

### App Tracks (Choose Your Path)
Each track has 3 phases that build on each other:
- Phase 1: Core functionality
- Phase 2: Enhanced features
- Phase 3: Monetization

### Build Your Own
After completing foundations + 2 tracks, students build their own product idea.

## Checkpoint Validation

MVPKit uses a layered validation approach:

1. **Automated** - File checks, build commands, linting
2. **Browser** - UI validation via MCP (when available)
3. **Conversational** - External service confirmations

## Tech Stack Taught

- **Next.js** - React framework
- **Convex** - Backend and database
- **Better Auth** - Authentication
- **Resend** - Email
- **Stripe** - Payments

## Integration with BMAD

MVPKit leverages the BMAD ecosystem:
- Step-file workflow architecture
- Expert agent with sidecar memory
- JIT loading for efficient context
- Menu-driven user control

Students learn BMAD methodology implicitly through the course, preparing them to use BMM agents when building their own products.

---

## Getting Started

1. Ensure you have the MVPKit starter code
2. Load the MVPKit Tutor agent: `/mvpkit:agents:mvpkit-tutor`
3. Say "start" to begin the first lesson

---

_Part of the MVPKit Course - Teaching non-technical founders to build real products._
