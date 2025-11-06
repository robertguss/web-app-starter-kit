/// <reference types="vite/client" />

// Export modules glob for convex-test
// This glob matches all files in the convex directory with a single extension ending in 's' or 'x'
// (like .ts, .js, .tsx, .jsx) but excludes files with multiple extensions (like .test.ts, .config.ts)
export const modules = import.meta.glob("./**/!(*.*.*)*.*s{,x}");
