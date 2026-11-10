/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_BASE_URL?: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}

interface Window {
  /** Optional runtime API base, same hook as the Flutter client. */
  __LOONGS_API_BASE_URL__?: string
}
