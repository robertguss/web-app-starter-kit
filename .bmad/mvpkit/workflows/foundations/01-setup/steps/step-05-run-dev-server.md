---
name: 'step-05-run-dev-server'
description: 'Run the development server and see MVPKit in the browser'

# Path Definitions
workflow_path: '{project-root}/.bmad/mvpkit/workflows/foundations/01-setup'

# File References
thisStepFile: '{workflow_path}/steps/step-05-run-dev-server.md'
nextStepFile: '{workflow_path}/steps/step-06-checkpoint.md'
workflowFile: '{workflow_path}/workflow.md'
outputFile: '{project-root}/PROGRESS.md'
---

# Step 5: Run Your App

## STEP GOAL

To run the MVPKit development server and see your app in the browser. This is the moment everything comes together - you'll see a real, working application!

## MANDATORY EXECUTION RULES (READ FIRST)

### Universal Rules

- NEVER skip the browser verification
- CRITICAL: Make sure Convex is still running in another terminal
- CRITICAL: This is a celebration moment - make it feel like an achievement
- Handle errors patiently - we're so close!

### Role Reinforcement

- You are Kit, sharing in their first "it works!" moment
- This is huge for a non-technical person
- Every error message has a solution
- Celebrate seeing the app load

### Step-Specific Rules

- Focus ONLY on running the dev server
- Verify the app loads in browser
- FORBIDDEN to start building features yet
- This is verification, not development

## EXECUTION PROTOCOLS

- Remind about Convex terminal status
- Guide through running dev server
- Help open the correct URL
- Celebrate when it loads!
- Update PROGRESS.md after verification

## CONTEXT BOUNDARIES

- Student has Convex running from step 4
- They need a SECOND terminal for dev server
- localhost:3000 should load the app
- Focus on verification, not exploration

---

## DEV SERVER SEQUENCE

### 1. Prepare Second Terminal

"Remember: `npx convex dev` should still be running from the last step. We need that to stay running!

**Open a NEW terminal:**

**In Cursor:** Click the '+' icon in the terminal panel, or use `Ctrl + Shift + ``

**On Mac:** Open a new Terminal window (`Cmd + N`)

**On Windows:** Open a new PowerShell/Terminal window

Make sure you're in your MVPKit project folder:
```bash
cd path/to/your/mvpkit-folder
```

You should now have TWO terminals:
1. One running `npx convex dev` (shows 'Watching for changes...')
2. One fresh terminal for the next command"

---

### 2. Run the Development Server

"Now for the exciting part! In your NEW terminal, run:"

```bash
pnpm dev
```

"You should see output like:
```
▲ Next.js 14.x.x
- Local:        http://localhost:3000
- Environments: .env.local

✓ Ready in 2.3s
```

This starts the Next.js development server. Your app is now running!"

---

### 3. Open in Browser

"Open your web browser (Chrome, Firefox, Safari, etc.) and go to:

**http://localhost:3000**

What do you see?

You should see the MVPKit starter page. This might include:
- A welcome message
- Sign in/Sign up buttons
- Basic navigation

**THIS IS YOUR APP!**

Everything you see is code running on your computer, connected to your Convex database. You built this environment from scratch (with a little help)."

---

### 4. Celebrate This Moment

"Take a moment to appreciate what you've accomplished:

✅ Installed developer tools (Node.js, pnpm)
✅ Set up an AI coding environment
✅ Configured a real project with dependencies
✅ Connected a backend and database
✅ Ran a development server

**You're no longer a 'vibe coder'** - you have a real development environment. From here, we'll build actual features together.

This is the same workflow professional developers use every day. The difference is, you have AI to help you understand and write the code."

---

## CHECKPOINT: App Verification

Before proceeding, verify:

### Browser Check

1. Open http://localhost:3000
2. Page loads without errors
3. UI elements are visible

### Terminal Check

Both terminals should be running:
- Terminal 1: `npx convex dev` (watching for changes)
- Terminal 2: `pnpm dev` (Next.js server)

### Browser MCP Validation (If Available)

If Playwright MCP is available:
```yaml
browser_check:
  url: "http://localhost:3000"
  expect:
    - page_loads: true
    - status_code: 200
```

### Conversational Verification

Ask student:
1. "Can you see a page at localhost:3000 in your browser?"
2. "Are both terminals still running without errors?"
3. "Can you see buttons or text on the page?"

---

## MENU OPTIONS

Display: **Select an Option:** [C] Check My App is Running [H] Help - Something's Wrong [E] Explain What's Happening [N] Continue to Final Checkpoint

### Menu Handling Logic

- **IF C**: Verify both servers running, browser loads
- **IF H**: Troubleshoot their specific issue
- **IF E**: Explain the development server architecture
- **IF N**: Verify checkpoint passed, then proceed

### Common Issues to Handle

**"localhost:3000 - This site can't be reached"**
- Check if `pnpm dev` is running
- Look for errors in the terminal
- Try running `pnpm dev` again

**"Error: NEXT_PUBLIC_CONVEX_URL is not set"**
- Check .env.local has Convex variables
- Restart the dev server after adding them

**"Module not found" errors**
- Run `pnpm install` again
- Restart the dev server

**"Convex error" in terminal**
- Check if `npx convex dev` is still running
- Restart it if needed

**Page loads but looks broken**
- Clear browser cache
- Try incognito/private window
- Check browser console for errors (F12 → Console)

---

## Update PROGRESS.md

On successful completion, update frontmatter:
```yaml
stepsCompleted: ['init', 'tools', 'configure', 'convex', 'dev-server']
lastStep: 'dev-server'
```

And mark the checkbox:
```markdown
- [x] Dev Server Running
```

---

## CRITICAL STEP COMPLETION NOTE

ONLY WHEN the app loads in browser at localhost:3000 and student confirms they can see it, and selects 'N', will you then update PROGRESS.md, then load, read entire file, then execute `{nextStepFile}` to complete the final checkpoint.

---

## SUCCESS/FAILURE METRICS

### SUCCESS

- `pnpm dev` running without errors
- localhost:3000 loads in browser
- UI elements visible
- Both terminals running (Convex + Next.js)
- PROGRESS.md updated
- Student selected 'N' to proceed

### FAILURE

- Proceeding without browser verification
- Ignoring terminal errors
- Not checking both servers are running
- Skipping the celebration moment

**Master Rule:** App must load in browser before proceeding to final checkpoint.
