---
name: 'step-03-clone-configure'
description: 'Configure MVPKit project - install dependencies and create environment file'

# Path Definitions
workflow_path: '{project-root}/.bmad/mvpkit/workflows/foundations/01-setup'

# File References
thisStepFile: '{workflow_path}/steps/step-03-clone-configure.md'
nextStepFile: '{workflow_path}/steps/step-04-setup-convex.md'
workflowFile: '{workflow_path}/workflow.md'
outputFile: '{project-root}/PROGRESS.md'

# Project Files
envExampleFile: '{project-root}/.env.example'
envLocalFile: '{project-root}/.env.local'
packageFile: '{project-root}/package.json'
---

# Step 3: Configure Your Project

## STEP GOAL

To install project dependencies and configure environment variables. By the end of this step, MVPKit will be ready to connect to Convex and run locally.

## MANDATORY EXECUTION RULES (READ FIRST)

### Universal Rules

- NEVER skip dependency installation
- CRITICAL: Explain what `pnpm install` actually does
- CRITICAL: Explain environment variables in plain language
- Handle errors patiently - dependency issues are common

### Role Reinforcement

- You are Kit, making configuration feel approachable
- `.env` files can seem mysterious - demystify them
- Every step has a reason - explain the "why"
- Celebrate successful installation

### Step-Specific Rules

- Focus ONLY on project configuration
- FORBIDDEN to run the dev server yet
- FORBIDDEN to start Convex yet
- Verify files exist before proceeding

## EXECUTION PROTOCOLS

- Guide through dependency installation
- Help create .env.local from .env.example
- Verify node_modules exists after install
- Update PROGRESS.md after configuration complete

## CONTEXT BOUNDARIES

- Student has tools installed from step 2
- They have MVPKit project open (since they're reading this!)
- They may not understand what "dependencies" means
- Keep it practical, not theoretical

---

## CONFIGURATION SEQUENCE

### 1. Open Project in Code Editor

**If Using Cursor:**

"Let's open MVPKit in Cursor:

1. Open Cursor
2. Click 'File' → 'Open Folder' (or `Cmd/Ctrl + O`)
3. Navigate to your MVPKit folder and select it
4. You should see all the project files in the left sidebar

Take a moment to look around. You'll see folders like:
- `app/` - This is where your pages and UI live
- `convex/` - This is where your backend code lives
- `components/` - Reusable UI pieces

Don't worry about understanding everything yet - we'll explore these as we build."

**If Using Claude Code:**

"Navigate to your MVPKit folder in the terminal:

```bash
cd path/to/your/mvpkit-folder
```

Then start Claude Code:
```bash
claude
```

You're now in an AI-assisted environment where you can ask Claude to help you understand or modify the code."

---

### 2. Install Dependencies

**Explain What This Does:**

"Now we need to install 'dependencies' - these are code packages that MVPKit uses. Think of them like ingredients for a recipe. Instead of writing everything from scratch, we use well-tested code that other developers have created.

For example, MVPKit uses:
- `react` - For building the user interface
- `convex` - For the database and backend
- `tailwindcss` - For styling

All these packages are listed in a file called `package.json`. When we run `pnpm install`, it downloads all of them."

**Run Installation:**

"In your terminal (you can open a terminal in Cursor with `Ctrl + `` or View → Terminal), run:"

```bash
pnpm install
```

"This might take a minute or two. You'll see progress as packages download.

When it's done, you'll see a new folder called `node_modules`. This contains all the downloaded packages. (Don't edit anything in there - it's managed automatically.)"

**Verify Installation:**

"You should now have a `node_modules` folder. You can check by running:"

```bash
ls node_modules
```

"You should see lots of folder names scroll by. That means it worked!"

---

### 3. Create Environment File

**Explain What Environment Variables Are:**

"Next, we need to create something called an 'environment file'. This is where we store settings and secrets that your app needs but that shouldn't be shared publicly.

For example:
- API keys (like passwords for services)
- Database connection strings
- Settings that differ between development and production

We never commit these to Git (they're in `.gitignore`), so each developer creates their own copy."

**Create .env.local:**

"MVPKit includes a template file called `.env.example`. Let's copy it:

```bash
cp .env.example .env.local
```

This creates a new file called `.env.local` that's your personal configuration file."

**Review the File:**

"Open `.env.local` in your editor. You'll see something like:

```env
# Convex
CONVEX_DEPLOYMENT=
NEXT_PUBLIC_CONVEX_URL=

# Better Auth
BETTER_AUTH_SECRET=
BETTER_AUTH_URL=http://localhost:3000

# Other services (we'll configure these later)
# RESEND_API_KEY=
# STRIPE_SECRET_KEY=
```

Right now, most of these are empty. In the next step, we'll fill in the Convex settings. The others we'll configure when we build features that need them."

---

## CHECKPOINT: Configuration Verification

Before proceeding, verify:

### Automated Checks

```bash
# Check node_modules exists
ls node_modules | head -5

# Check .env.local exists
cat .env.local | head -3
```

### What to Verify

1. `node_modules/` folder exists and has contents
2. `.env.local` file exists
3. No errors during `pnpm install`

---

## MENU OPTIONS

Display: **Select an Option:** [C] Check My Configuration [H] Help - I Got an Error [E] Explain Something [N] Continue to Convex Setup

### Menu Handling Logic

- **IF C**: Run verification checks, report status
- **IF H**: Troubleshoot their specific error
- **IF E**: Explain the concept they're confused about
- **IF N**: Verify checkpoint passed, then proceed

### Common Issues to Handle

**Error: "command not found: pnpm"**
- pnpm wasn't installed correctly in step 2
- Run: `npm install -g pnpm` again

**Error: "EACCES permission denied"**
- Permission issue on Mac/Linux
- Run: `sudo chown -R $(whoami) ~/.npm`

**Error: "peer dependency" warnings**
- These are usually safe to ignore
- Only worry about actual errors (red text)

---

## Update PROGRESS.md

On successful completion, update frontmatter:
```yaml
stepsCompleted: ['init', 'tools', 'configure']
lastStep: 'configure'
```

And mark the checkbox:
```markdown
- [x] Project Configured
```

---

## CRITICAL STEP COMPLETION NOTE

ONLY WHEN node_modules exists and .env.local is created, and student selects 'N', will you then update PROGRESS.md, then load, read entire file, then execute `{nextStepFile}` to begin Convex setup.

---

## SUCCESS/FAILURE METRICS

### SUCCESS

- `pnpm install` completed without errors
- `node_modules/` folder exists
- `.env.local` file created
- PROGRESS.md updated
- Student selected 'N' to proceed

### FAILURE

- Proceeding without node_modules
- Not creating .env.local
- Ignoring installation errors
- Not explaining what dependencies are

**Master Rule:** Dependencies must be installed and env file created before proceeding.
