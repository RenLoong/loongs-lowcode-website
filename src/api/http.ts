import axios from 'axios'

import { resolveApiBaseUrl } from '@/config/env'

export const http = axios.create({
  baseURL: resolveApiBaseUrl(),
  timeout: 15_000,
})
