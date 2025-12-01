# MVPKit Tech Stack Reference

## Overview

MVPKit uses a modern, beginner-friendly stack optimized for building real products quickly with AI assistance.

## Core Technologies

### Next.js (Frontend Framework)
**What it is:** A React framework for building web applications.

**Why we use it:**
- Industry standard - huge community and resources
- Built-in routing (pages = URLs)
- Server and client rendering
- Easy deployment (Vercel)
- Great AI tool support (Cursor, Claude Code understand it well)

**Key concepts for students:**
- Pages in `app/` folder become routes
- Components are reusable UI pieces
- Server vs Client components (use 'use client' for interactive stuff)

### Convex (Backend/Database)
**What it is:** A real-time backend platform that handles database, server functions, and real-time sync.

**Why we use it (instead of Supabase):**
- TypeScript end-to-end (one language everywhere)
- Real-time by default (data syncs automatically)
- No SQL needed (write functions, not queries)
- Built-in file storage
- Components ecosystem for adding features

**Key concepts for students:**
- `convex/` folder contains all backend code
- Functions in `convex/` are your API
- Schemas define your data structure
- Mutations change data, queries read data
- Real-time: UI updates automatically when data changes

### Better Auth (Authentication)
**What it is:** A modern authentication library for Next.js.

**Why we use it:**
- Simple setup
- Works great with Convex
- Supports social login (Google, GitHub, etc.)
- Session management handled for you

**Key concepts for students:**
- Users sign up/sign in through Better Auth
- Session tells us who's logged in
- Protected routes check for session
- User data stored in Convex

### Resend (Email)
**What it is:** Developer-friendly email sending service.

**Why we use it:**
- Simple API
- Great React Email integration
- Free tier is generous
- Reliable delivery

**Key concepts for students:**
- Send emails from server functions
- Templates in React (React Email)
- Transactional emails (confirmations, notifications)

### Stripe (Payments)
**What it is:** Payment processing platform.

**Why we use it:**
- Industry standard
- Handles security/compliance
- Subscriptions and one-time payments
- Webhooks for payment events

**Key concepts for students:**
- Checkout Sessions for payments
- Webhooks notify your app of events
- Products/Prices in Stripe Dashboard
- Customer portal for subscription management

## AI Tools

### Cursor
**What it is:** AI-powered code editor based on VS Code.

**Key features:**
- Chat with AI about your code
- AI can edit files directly
- Understands your codebase context
- Tab completion with AI

### Claude Code
**What it is:** Anthropic's CLI tool for AI-assisted development.

**Key features:**
- Terminal-based interface
- Can read and write files
- Understands project context
- Great for complex tasks

## Common Patterns in MVPKit

### Data Flow
```
User Action → Convex Mutation → Database Update → Real-time Sync → UI Update
```

### Authentication Flow
```
User → Better Auth → Session Created → Convex gets user ID → Protected actions work
```

### Payment Flow
```
User clicks pay → Stripe Checkout → Payment processed → Webhook → Convex updates user → Access granted
```

## Glossary for Students

- **API:** How different parts of an app talk to each other
- **Component:** A reusable piece of UI
- **Database:** Where your app stores data
- **Deploy:** Making your app available on the internet
- **Endpoint:** A specific URL your app responds to
- **Environment Variables:** Secret settings stored outside your code
- **Frontend:** What users see and interact with
- **Backend:** Server-side logic and data
- **Mutation:** A function that changes data
- **Query:** A function that reads data
- **Real-time:** Data that updates automatically without refreshing
- **Route:** A URL path in your app
- **Schema:** The structure/shape of your data
- **Webhook:** A notification from one service to another

---

_Use this reference to explain concepts in context during lessons._
