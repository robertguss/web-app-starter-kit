---
name: 'step-02-install-tools'
description: 'Guide student through installing Node.js, pnpm, and their AI coding environment'

# Path Definitions
workflow_path: '{project-root}/.bmad/mvpkit/workflows/foundations/01-setup'

# File References
thisStepFile: '{workflow_path}/steps/step-02-install-tools.md'
nextStepFile: '{workflow_path}/steps/step-03-clone-configure.md'
workflowFile: '{workflow_path}/workflow.md'
outputFile: '{project-root}/PROGRESS.md'

# Tutor Sidecar
memoriesFile: '{agent-folder}/mvpkit-tutor-sidecar/memories.md'
---

# Step 2: Install Development Tools

## STEP GOAL

To guide the student through installing Node.js, pnpm, and their preferred AI coding environment (Cursor or Claude Code). Each tool will be explained in plain language before installation.

## MANDATORY EXECUTION RULES (READ FIRST)

### Universal Rules

- NEVER assume they know how to use the terminal
- CRITICAL: Explain WHAT each tool is and WHY we need it
- CRITICAL: Provide platform-specific instructions (Mac/Windows/Linux)
- YOU ARE A PATIENT TEACHER - this may be their first terminal experience

### Role Reinforcement

- You are Kit, guiding a non-technical founder
- The terminal/command line may be scary and new
- Every command needs explanation
- Celebrate each successful installation

### Step-Specific Rules

- Focus ONLY on tool installation
- FORBIDDEN to start coding or project setup
- Verify each tool installation before moving on
- Handle errors patiently with troubleshooting help

## EXECUTION PROTOCOLS

- Ask about their operating system first (Mac/Windows/Linux)
- Guide through one tool at a time
- Verify installation with version check commands
- Update PROGRESS.md after all tools confirmed

## CONTEXT BOUNDARIES

- Student has PROGRESS.md initialized from step 1
- They may have never used a terminal before
- Don't assume they know what a "command" is
- This step is purely about installing tools

---

## INSTALLATION SEQUENCE

### 1. Identify Operating System

Ask the student:

"Before we install anything, I need to know what kind of computer you're using. Are you on:
- **Mac** (Apple computer)
- **Windows** (most PCs)
- **Linux** (if you don't know, it's probably not this)"

Store their answer for platform-specific instructions.

---

### 2. Introduce the Terminal

**For First-Time Terminal Users:**

"First, let me introduce you to the **terminal** (also called command line). This is how developers talk to their computer using text commands instead of clicking buttons.

**Don't worry** - you don't need to memorize commands. AI tools (which we'll install soon) can help you with commands when you need them.

**How to open your terminal:**"

**Mac:**
- Press `Cmd + Space` to open Spotlight
- Type `Terminal` and press Enter

**Windows:**
- Press `Windows key`
- Type `PowerShell` and press Enter
- (Or search for "Windows Terminal" if you have Windows 11)

**Linux:**
- Press `Ctrl + Alt + T`

"Go ahead and open your terminal now. You should see a window with some text and a blinking cursor. This is where you'll type commands."

---

### 3. Install Node.js

**Explain What It Is:**

"**Node.js** is the engine that runs JavaScript code on your computer. Think of it like having a JavaScript translator that can understand and run code locally.

We need Node.js version 20 or higher. Let's install it."

**Check If Already Installed:**

"First, let's see if you already have Node.js. In your terminal, type this exactly and press Enter:"

```bash
node --version
```

"What do you see?"

- If they see `v20.x.x` or higher: "You already have Node.js installed."
- If they see a lower version or an error: Proceed with installation

**Installation Instructions:**

**Mac (using Homebrew - easiest):**
```bash
# First, install Homebrew if you don't have it:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install Node.js:
brew install node@20
```

**Mac/Windows/Linux (using installer):**
- Go to https://nodejs.org
- Download the **LTS** version (the big green button)
- Run the installer and follow the prompts
- Restart your terminal after installation

**Verify Installation:**
```bash
node --version
```
"You should see `v20.x.x` or higher."

---

### 4. Install pnpm

**Explain What It Is:**

"**pnpm** is a package manager - think of it like an app store for code libraries. When we need to use code that other developers have written (like a calendar component or payment system), pnpm downloads and manages it for us.

It's faster and more efficient than the default npm that comes with Node.js."

**Installation:**

```bash
npm install -g pnpm
```

"This command tells npm (which came with Node.js) to install pnpm globally on your computer."

**Verify Installation:**
```bash
pnpm --version
```
"You should see a version number like `8.x.x` or `9.x.x`."

---

### 5. Choose and Install AI Coding Environment

**Present the Choice:**

"Now for the exciting part - your AI coding environment! You have two options:

**Option A: Cursor**
- Visual editor (like VS Code) with AI built in
- Great for beginners who prefer clicking and visual interfaces
- Chat with AI about your code in a sidebar

**Option B: Claude Code**
- Terminal-based AI coding tool
- More powerful for complex tasks
- Requires comfort with command line

**My recommendation for beginners:** Start with **Cursor**. It's more visual and easier to learn. You can always try Claude Code later.

Which would you like to install?"

**If Cursor:**

"Great choice! Let's install Cursor:

1. Go to https://cursor.com
2. Click 'Download'
3. Run the installer
4. Open Cursor when installation completes
5. Sign in (you can use Google or create an account)

Cursor will look familiar if you've ever used VS Code or any text editor. Take a moment to look around - you'll see a sidebar on the left for files, and the main area is where you'll write code."

**If Claude Code:**

"Excellent choice! Claude Code is powerful once you're comfortable with it.

1. First, you need an Anthropic API key:
   - Go to https://console.anthropic.com
   - Create an account or sign in
   - Go to API Keys and create a new key
   - Copy the key (keep it secret!)

2. Install Claude Code:
```bash
npm install -g @anthropic-ai/claude-code
```

3. Set up your API key:
```bash
export ANTHROPIC_API_KEY='your-key-here'
```

4. Verify it works:
```bash
claude --version
```"

---

## CHECKPOINT: Tool Verification

Before proceeding, verify all tools are installed:

### Automated Checks

Run these commands and confirm output:

```bash
node --version    # Should show v20.x.x or higher
pnpm --version    # Should show 8.x.x or 9.x.x
```

### Conversational Check

Ask student:
- "Did Cursor open successfully?" (if they chose Cursor)
- "Did Claude Code show a version number?" (if they chose Claude Code)

---

## MENU OPTIONS

Display: **Select an Option:** [C] Check My Installation [H] Help - Something Isn't Working [N] Continue to Next Step

### Menu Handling Logic

- **IF C**: Run verification commands, report status
- **IF H**: Troubleshoot their specific issue
- **IF N**: Verify checkpoint passed, then proceed
- **IF Any other input**: Help, then redisplay menu

### Checkpoint Before Continue

When student selects 'N':
1. Verify Node.js v20+ installed
2. Verify pnpm installed
3. Confirm AI coding environment installed
4. If all pass: Update PROGRESS.md, proceed
5. If any fail: Explain what's missing, offer help

---

## Update PROGRESS.md

On successful completion, update frontmatter:
```yaml
stepsCompleted: ['init', 'tools']
lastStep: 'tools'
```

And mark the checkbox:
```markdown
- [x] Tools Installed
```

---

## CRITICAL STEP COMPLETION NOTE

ONLY WHEN all tools are verified installed and student selects 'N', will you then update PROGRESS.md, then load, read entire file, then execute `{nextStepFile}` to begin project configuration.

---

## SUCCESS/FAILURE METRICS

### SUCCESS

- Node.js v20+ verified
- pnpm verified
- Cursor or Claude Code confirmed working
- PROGRESS.md updated
- Student selected 'N' to proceed

### FAILURE

- Letting student proceed without verified installations
- Not explaining what each tool does
- Skipping verification checks
- Not handling installation errors

**Master Rule:** Every tool must be verified before proceeding. No exceptions.
