# Authentication Guide

Complete guide to authentication in the AI Starter Kit using Better Auth + Convex.

---

## Overview

This starter uses **Better Auth** with native Convex integration for:

- Email/password authentication
- Session management
- Protected routes
- User account management

---

## How It Works

### Architecture

```
User → Login Form → Next.js API Route → Convex HTTP Endpoint
                    (/api/auth/*)        (https://deployment.convex.site/api/auth/*)
                          ↓
                    Proxies request
                          ↓
                    Better Auth validates credentials
                          ↓
                    Creates session in Convex DB
                          ↓
                    Returns session cookie
                          ↓
                    Redirects to dashboard
```

### How the Auth Proxy Works

The authentication flow uses a **proxy pattern**:

1. **Frontend** calls `/api/auth/*` endpoints (e.g., `/api/auth/get-session`)
2. **Next.js API Route** (`app/api/auth/[...all]/route.ts`) receives the request
3. **Proxy Handler** (`nextJsHandler` from `@convex-dev/better-auth/nextjs`) forwards the request to Convex
4. **Convex HTTP Routes** (`convex/http.ts`) process the auth request using Better Auth
5. **Response** flows back through the proxy to the frontend

**Critical Configuration**: The proxy uses `NEXT_PUBLIC_CONVEX_SITE_URL` to know where to forward requests. This MUST be set to your Convex HTTP endpoint (e.g., `https://your-deployment.convex.site`), NOT `localhost:3000`.

### Configuration Files

- `convex/auth.config.ts` - Better Auth settings
- `convex/auth.ts` - Auth helper functions
- `convex/http.ts` - HTTP routes for auth (registers Better Auth endpoints)
- `app/api/auth/[...all]/route.ts` - Next.js proxy to Convex auth endpoints
- `lib/auth-client.ts` - Frontend auth client
- `middleware.ts` - Route protection

### Environment Variables Required

```bash
# In Convex (set via `npx convex env set`)
BETTER_AUTH_SECRET   # Encryption key (32+ characters)
SITE_URL             # Your app's base URL (http://localhost:3000 for dev)

# In .env.local (Next.js)
NEXT_PUBLIC_CONVEX_URL       # Convex cloud URL (auto-generated)
NEXT_PUBLIC_CONVEX_SITE_URL  # Convex HTTP endpoint (MUST end in .convex.site)
```

> **Warning**: If `NEXT_PUBLIC_CONVEX_SITE_URL` is set to `localhost:3000`, the proxy will loop back to itself, causing 500 errors with ~10 second timeouts.

---

## Using Authentication

### Sign Up

```typescript
import { authClient } from "@/lib/auth-client";

await authClient.signUp.email({
  email: "user@example.com",
  password: "securepassword",
  name: "John Doe", // optional
});
```

### Sign In

```typescript
await authClient.signIn.email({
  email: "user@example.com",
  password: "securepassword",
});
```

### Sign Out

```typescript
await authClient.signOut();
```

### Get Current Session

```typescript
const session = await authClient.getSession();
if (session) {
  console.log(session.user.email);
}
```

---

## Protected Routes

### Middleware Protection

All `/dashboard/*` routes are automatically protected by `middleware.ts`:

```typescript
// middleware.ts
export async function middleware(request: NextRequest) {
  if (request.nextUrl.pathname.startsWith("/dashboard")) {
    // Check session
    const session = await getSession();
    if (!session) {
      return NextResponse.redirect("/login?redirect=" + pathname);
    }
  }
}
```

### Protect Convex Functions

```typescript
import { authComponent } from "./auth";

export const myProtectedQuery = query({
  args: {},
  handler: async (ctx) => {
    const user = await authComponent.getAuthUser(ctx);
    if (!user) {
      throw new Error("Unauthorized");
    }

    // User is authenticated
    return { userId: user.id };
  },
});
```

---

## Customization

### Change Session Duration

Edit `convex/auth.config.ts`:

```typescript
export const authConfig = {
  session: {
    expiresIn: 60 * 60 * 24 * 30, // 30 days (in seconds)
  },
};
```

### Enable Email Verification

```typescript
export const authConfig = {
  requireEmailVerification: true,
  // Configure email sending...
};
```

### Add OAuth Providers

Coming soon! See [ROADMAP.md](../ROADMAP.md)

---

## Database Tables

Better Auth creates these tables automatically:

- **authUser** - User accounts
- **authAccount** - Login methods (email, OAuth)
- **authSession** - Active sessions
- **authVerification** - Email verification tokens

**Do not manually modify these tables!**

---

## Security Best Practices

- ✅ Passwords are hashed with bcrypt
- ✅ Sessions are encrypted
- ✅ CSRF protection enabled
- ✅ Secure cookies (httpOnly, sameSite)
- ✅ Environment variables for secrets

---

**Previous:** [← Database](./DATABASE.md) | **Next:** [Troubleshooting →](./TROUBLESHOOTING.md)
