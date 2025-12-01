---
name: 'step-04-setup-convex'
description: 'Create Convex account and connect the project to Convex backend'

# Path Definitions
workflow_path: '{project-root}/.bmad/mvpkit/workflows/foundations/01-setup'

# File References
thisStepFile: '{workflow_path}/steps/step-04-setup-convex.md'
nextStepFile: '{workflow_path}/steps/step-05-run-dev-server.md'
workflowFile: '{workflow_path}/workflow.md'
outputFile: '{project-root}/PROGRESS.md'

# Project Files
envLocalFile: '{project-root}/.env.local'
convexFolder: '{project-root}/convex'
---

# Step 4: Connect to Convex

## STEP GOAL

To create a Convex account, connect MVPKit to Convex, and verify the connection works. By the end of this step, your app will have a working backend and database.

## MANDATORY EXECUTION RULES (READ FIRST)

### Universal Rules

- NEVER skip Convex account creation
- CRITICAL: Explain what Convex is and why we use it
- CRITICAL: Verify the dashboard shows the project
- This is the first external service - be extra patient

### Role Reinforcement

- You are Kit, making backend setup feel achievable
- "Backend" and "database" can be intimidating terms
- Use analogies - Convex is like a smart storage locker
- Celebrate seeing the project appear in the dashboard

### Step-Specific Rules

- Focus ONLY on Convex connection
- FORBIDDEN to run the full dev server yet
- Verify connection before proceeding
- Help troubleshoot auth/connection issues

## EXECUTION PROTOCOLS

- Guide through Convex account creation
- Run `npx convex dev` to connect
- Verify project appears in Convex dashboard
- Update .env.local with Convex settings
- Update PROGRESS.md after connection verified

## CONTEXT BOUNDARIES

- Student has dependencies installed from step 3
- They have .env.local file ready
- They may not understand what a "backend" is
- Focus on the practical, not the theoretical

---

## CONVEX SETUP SEQUENCE

### 1. Explain What Convex Is

"Before we set up Convex, let me explain what it does.

**What is Convex?**

Convex is your app's 'backend' - which means it handles:
- **Database**: Where your app stores data (users, bookings, products, etc.)
- **Server Functions**: Code that runs on a server instead of in the browser
- **Real-time Sync**: When data changes, your UI updates automatically

**Why Convex (instead of alternatives)?**

1. **TypeScript everywhere** - One language for everything
2. **Real-time by default** - No extra setup for live updates
3. **No SQL** - You write functions, not database queries
4. **Great for beginners** - Less configuration than alternatives

Think of Convex as a smart storage locker that also knows how to organize and retrieve your stuff exactly how you need it."

---

### 2. Create Convex Account

"Let's create your Convex account:

1. Go to **https://dashboard.convex.dev**
2. Click **'Sign Up'** or **'Get Started'**
3. You can sign up with:
   - GitHub (recommended if you have one)
   - Google
   - Email

4. Complete the signup process

Once you're in, you'll see the Convex dashboard. It might be empty right now - that's okay! We're about to create your first project."

**Wait for confirmation:**
"Let me know when you've created your account and can see the dashboard."

---

### 3. Connect MVPKit to Convex

"Now we'll connect your MVPKit project to Convex. This command does several things:
- Creates a new Convex project (or connects to existing one)
- Sets up the database schema
- Starts syncing your local code with Convex

**Run this command in your terminal:**"

```bash
npx convex dev
```

"The first time you run this:
1. It will open a browser window to authenticate
2. Click 'Authorize' to give it permission
3. Back in the terminal, it will ask you to create a new project or select an existing one
4. Choose 'Create a new project'
5. Name it something like 'mvpkit' or your project name

You should see output like:
```
✔ Connected to project mvpkit-abc123
✔ Deployed functions
```

**Keep this terminal running!** Convex dev needs to stay running to sync your code."

---

### 4. Verify Dashboard Connection

"Now let's verify the connection:

1. Go back to **https://dashboard.convex.dev**
2. You should see your new project listed
3. Click on it to open the project dashboard
4. You should see:
   - **Functions** tab - Shows your backend functions
   - **Data** tab - Where you'll see database tables
   - **Logs** tab - For debugging

Can you see your project in the dashboard?"

---

### 5. Update Environment Variables

"Convex should have automatically updated your `.env.local` file. Let's verify:

Open `.env.local` and check that these values are now filled in:

```env
CONVEX_DEPLOYMENT=dev:your-project-name
NEXT_PUBLIC_CONVEX_URL=https://your-project-name.convex.cloud
```

If they're empty, you can find these values in your Convex dashboard under Settings → URL & Deploy Key."

---

## CHECKPOINT: Convex Verification

Before proceeding, verify:

### Automated Check

```bash
# Check Convex generated files exist
ls convex/_generated/
```

You should see files like `api.d.ts` and `server.d.ts`.

### Conversational Checks

Ask student:
1. "Is `npx convex dev` still running in your terminal? (You should see it watching for changes)"
2. "Can you see your project in the Convex dashboard at dashboard.convex.dev?"
3. "Does your `.env.local` have CONVEX_DEPLOYMENT and NEXT_PUBLIC_CONVEX_URL filled in?"

---

## MENU OPTIONS

Display: **Select an Option:** [C] Check My Convex Connection [H] Help - Connection Issues [E] Explain Convex More [N] Continue to Run Dev Server

### Menu Handling Logic

- **IF C**: Run verification checks, report status
- **IF H**: Troubleshoot their specific issue
- **IF E**: Provide deeper explanation of Convex concepts
- **IF N**: Verify checkpoint passed, then proceed

### Common Issues to Handle

**"Command not found: npx"**
- Node.js wasn't installed correctly
- Go back to step 2 and reinstall

**"Failed to authenticate"**
- Clear browser cookies for convex.dev
- Try running `npx convex logout` then `npx convex dev` again

**"Project not appearing in dashboard"**
- Refresh the dashboard page
- Make sure you're logged into the same account
- Check the terminal for any error messages

**".env.local not updated"**
- Copy values manually from Convex dashboard → Settings
- CONVEX_DEPLOYMENT and NEXT_PUBLIC_CONVEX_URL

---

## Update PROGRESS.md

On successful completion, update frontmatter:
```yaml
stepsCompleted: ['init', 'tools', 'configure', 'convex']
lastStep: 'convex'
```

And mark the checkbox:
```markdown
- [x] Convex Connected
```

---

## CRITICAL STEP COMPLETION NOTE

ONLY WHEN Convex is connected (verified by dashboard and generated files), and student selects 'N', will you then update PROGRESS.md, then load, read entire file, then execute `{nextStepFile}` to run the dev server.

**IMPORTANT:** Remind student to keep `npx convex dev` running in a terminal. They'll need to open a NEW terminal for the next step.

---

## SUCCESS/FAILURE METRICS

### SUCCESS

- Convex account created
- Project connected via `npx convex dev`
- Project visible in Convex dashboard
- `.env.local` has Convex variables filled
- `convex/_generated/` folder has files
- PROGRESS.md updated
- Student selected 'N' to proceed

### FAILURE

- Proceeding without Convex connection
- Not verifying dashboard visibility
- .env.local missing Convex variables
- Generated files don't exist

**Master Rule:** Convex must be connected and verified before proceeding.
