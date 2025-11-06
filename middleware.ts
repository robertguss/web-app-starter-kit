import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { createAuth } from "./convex/auth";

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Protect the /dashboard route
  if (pathname.startsWith("/dashboard")) {
    try {
      // Get the auth token from cookies
      const token = request.cookies.get("better-auth.session_token")?.value;

      if (!token) {
        // No token, redirect to login
        const url = request.nextUrl.clone();
        url.pathname = "/login";
        url.searchParams.set("redirect", pathname);
        return NextResponse.redirect(url);
      }

      // Token exists, allow the request to proceed
      return NextResponse.next();
    } catch (error) {
      console.error("Middleware auth error:", error);
      // On error, redirect to login
      const url = request.nextUrl.clone();
      url.pathname = "/login";
      return NextResponse.redirect(url);
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - api (API routes)
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     */
    "/((?!api|_next/static|_next/image|favicon.ico).*)",
  ],
};
