/** API base URL: runtime inject first, then Vite env, then local default. */

const DEFAULT_API_BASE_URL = 'http://127.0.0.1:21000'

/** Replace `{host}` with the page hostname (IPv6 literals are bracketed). */
export function resolveHostPlaceholder(
  value: string,
  pageHost: string = typeof window === 'undefined' ? '127.0.0.1' : window.location.hostname,
): string {
  if (!value.includes('{host}')) return value
  let host = pageHost || '127.0.0.1'
  if (host.includes(':') && !host.startsWith('[')) {
    host = `[${host}]`
  }
  return value.replaceAll('{host}', host)
}

/**
 * Prefer `window.__LOONGS_API_BASE_URL__` (same hook as the Flutter client),
 * then `VITE_API_BASE_URL`, then http://127.0.0.1:21000.
 */
export function resolveApiBaseUrl(): string {
  const runtime = typeof window === 'undefined' ? undefined : window.__LOONGS_API_BASE_URL__?.trim()
  const configured = runtime || import.meta.env.VITE_API_BASE_URL || DEFAULT_API_BASE_URL
  return resolveHostPlaceholder(configured).replace(/\/$/, '')
}
