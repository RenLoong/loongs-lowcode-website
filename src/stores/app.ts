import { ref } from 'vue'
import { defineStore } from 'pinia'

import { resolveApiBaseUrl } from '@/config/env'

export const useAppStore = defineStore('app', () => {
  const sidebarCollapsed = ref(false)
  const apiBaseUrl = ref(resolveApiBaseUrl())

  function toggleSidebar() {
    sidebarCollapsed.value = !sidebarCollapsed.value
  }

  return { sidebarCollapsed, apiBaseUrl, toggleSidebar }
})
