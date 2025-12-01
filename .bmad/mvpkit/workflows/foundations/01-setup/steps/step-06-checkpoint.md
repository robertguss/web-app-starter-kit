---
name: 'step-06-checkpoint'
description: 'Final validation checkpoint and celebration of completing the setup lesson'

# Path Definitions
workflow_path: '{project-root}/.bmad/mvpkit/workflows/foundations/01-setup'

# File References
thisStepFile: '{workflow_path}/steps/step-06-checkpoint.md'
workflowFile: '{workflow_path}/workflow.md'
outputFile: '{project-root}/PROGRESS.md'
checkpointFile: '{workflow_path}/checkpoint.yaml'

# Tutor Sidecar
memoriesFile: '{agent-folder}/mvpkit-tutor-sidecar/memories.md'

# Next Lesson (for preview)
nextLessonWorkflow: '{project-root}/.bmad/mvpkit/workflows/foundations/02-how-apps-work/workflow.md'
---

# Step 6: Final Checkpoint

## STEP GOAL

To run a comprehensive validation of the entire setup, celebrate completion, and preview what's next. This is the final step of the Setup lesson.

## MANDATORY EXECUTION RULES (READ FIRST)

### Universal Rules

- CRITICAL: Run ALL validation checks before marking complete
- CRITICAL: This is a celebration - acknowledge the achievement
- NEVER skip validation even if previous steps passed
- Update all progress tracking files

### Role Reinforcement

- You are Kit, celebrating their accomplishment
- This is a significant milestone for a non-technical person
- Preview the next lesson to build anticipation
- Save session notes for continuity

### Step-Specific Rules

- Focus on validation and celebration
- Run comprehensive checks
- Mark lesson as complete
- Preview what comes next

## EXECUTION PROTOCOLS

- Run all automated checks
- Verify all conversational confirmations
- Update PROGRESS.md with completion
- Update tutor memories
- Show completion celebration
- Preview next lesson

---

## COMPREHENSIVE VALIDATION

### Layer 1: Automated Checks

Run these validations:

```bash
# 1. Node.js version
node --version
# Expected: v20.x.x or higher

# 2. pnpm installed
pnpm --version
# Expected: 8.x.x or 9.x.x

# 3. Dependencies installed
ls node_modules | head -3
# Expected: Shows package folders

# 4. Environment file exists
cat .env.local | head -5
# Expected: Shows Convex variables

# 5. Convex generated files
ls convex/_generated/
# Expected: Shows api.d.ts, server.d.ts

# 6. Build check (comprehensive)
pnpm run build
# Expected: Completes without errors
```

### Layer 2: Service Checks

Verify running services:

1. **Convex Dev Server**
   - `npx convex dev` running in terminal
   - Shows "Watching for changes..."

2. **Next.js Dev Server**
   - `pnpm dev` running in terminal
   - Shows "Ready" message

### Layer 3: Browser Validation

If Browser MCP available:
```yaml
browser_validation:
  url: "http://localhost:3000"
  checks:
    - page_loads: true
    - status_code: 200
    - no_console_errors: true
```

Manual browser check:
- localhost:3000 loads
- Page displays content
- No error screens

### Layer 4: Conversational Confirmation

Ask student:
1. "Is localhost:3000 showing your app in the browser?"
2. "Can you see your project in the Convex dashboard?"
3. "Do you have both terminals running (Convex and Next.js)?"

---

## VALIDATION RESULTS

### All Checks Passed

If ALL validations pass:

---

**🎉 CONGRATULATIONS!**

You've completed the Setup lesson!

**What you accomplished:**
- ✅ Installed Node.js and pnpm
- ✅ Set up Cursor/Claude Code as your AI coding environment
- ✅ Configured MVPKit with all dependencies
- ✅ Connected Convex for your backend and database
- ✅ Got a real development environment running

**You now have:**
- A complete development setup
- A working app you can see and interact with
- The foundation to start building features

**This is the same workflow that professional developers use.** The difference is, you now have AI as your development partner.

---

### Any Check Failed

If ANY validation fails:
1. Identify which check failed
2. Go back to the relevant step
3. Resolve the issue
4. Return to this checkpoint

Do NOT mark lesson complete until all checks pass.

---

## MARK LESSON COMPLETE

### Update PROGRESS.md

Update frontmatter:
```yaml
stepsCompleted: ['init', 'tools', 'configure', 'convex', 'dev-server', 'checkpoint']
lastStep: 'checkpoint'
completedAt: [current date/time]
lessonComplete: true
```

Update checkboxes:
```markdown
### 01-Setup: Environment & Tools
- [x] Initialized
- [x] Tools Installed
- [x] Project Configured
- [x] Convex Connected
- [x] Dev Server Running
- [x] Setup Complete ✓
```

### Update Tutor Memories

Update `{memoriesFile}` with:
```markdown
### [Date] - Completed: Foundations 01-Setup

**Achievements:**
- Successfully set up complete development environment
- Connected Convex backend
- App running locally

**Notes:**
- Operating system: [Mac/Windows/Linux]
- AI tool chosen: [Cursor/Claude Code]
- Any difficulties encountered: [notes]
- Time to complete: [estimate]

**Ready for:** Lesson 02 - How Apps Work
```

---

## PREVIEW NEXT LESSON

"**What's Next: How Apps Work**

In the next lesson, we'll explore HOW your app actually works:
- What happens when someone visits a page
- How the frontend and backend communicate
- Where data lives and how it flows
- The mental model that makes everything click

You don't need to memorize code syntax - AI handles that. But understanding how the pieces fit together will make you a much more effective product builder.

When you're ready to continue, just say 'start' and we'll begin the next lesson."

---

## MENU OPTIONS

Display: **Select an Option:** [V] Verify All Checks Again [S] Save Progress & Exit [N] Start Next Lesson

### Menu Handling Logic

- **IF V**: Re-run all validations
- **IF S**: Save session, show exit summary
- **IF N**: Load next lesson workflow (02-how-apps-work)

### Exit Summary (If Selecting 'S')

"**Session saved!**

Your progress:
- Lesson 01-Setup: ✅ Complete
- Current position: Ready for Lesson 02

Next time you return, just say 'start' and I'll remember where you left off.

Great work today! 🚀"

---

## CRITICAL STEP COMPLETION NOTE

This is the FINAL step of Lesson 01. Upon completion:
1. All validations must pass
2. PROGRESS.md marked complete
3. Tutor memories updated
4. Student can either exit or continue to next lesson

---

## SUCCESS/FAILURE METRICS

### SUCCESS

- All automated checks pass
- Browser shows working app
- Services confirmed running
- PROGRESS.md marked complete
- Tutor memories updated
- Student celebrated and previewed next lesson

### FAILURE

- Marking complete without all checks passing
- Skipping browser verification
- Not updating progress files
- Not celebrating the achievement

**Master Rule:** Setup lesson is ONLY complete when ALL validations pass.
