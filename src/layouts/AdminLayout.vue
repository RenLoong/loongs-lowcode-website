<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { Expand, Fold, House, Monitor } from '@element-plus/icons-vue'

import { useAppStore } from '@/stores/app'

const route = useRoute()
const app = useAppStore()

const active = computed(() => route.path)
</script>

<template>
  <el-container class="layout">
    <el-aside :width="app.sidebarCollapsed ? '64px' : '220px'" class="aside">
      <div class="logo">
        <el-icon :size="22"><Monitor /></el-icon>
        <span v-show="!app.sidebarCollapsed" class="logo-text">LOONGS Website</span>
      </div>
      <el-menu
        :default-active="active"
        :collapse="app.sidebarCollapsed"
        :collapse-transition="false"
        background-color="#304156"
        text-color="#bfcbd9"
        active-text-color="#409eff"
        router
      >
        <el-menu-item index="/">
          <el-icon><House /></el-icon>
          <span>首页</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container class="body">
      <el-header class="header">
        <el-icon class="collapse-btn" @click="app.toggleSidebar()">
          <Fold v-if="!app.sidebarCollapsed" />
          <Expand v-else />
        </el-icon>
        <span class="header-title">Web PC</span>
      </el-header>
      <el-main class="main">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<style scoped>
.layout {
  height: 100%;
}

.aside {
  overflow: hidden;
  background: #304156;
  transition: width 0.2s ease;
}

.logo {
  display: flex;
  align-items: center;
  gap: 10px;
  height: 56px;
  padding: 0 16px;
  color: #fff;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
}

.logo-text {
  font-size: 15px;
}

.aside :deep(.el-menu) {
  border-right: none;
}

.body {
  min-width: 0;
}

.header {
  display: flex;
  align-items: center;
  gap: 12px;
  height: 56px;
  padding: 0 16px;
  background: #fff;
  border-bottom: 1px solid #ebeef5;
}

.collapse-btn {
  font-size: 20px;
  cursor: pointer;
  color: #303133;
}

.header-title {
  font-size: 16px;
  font-weight: 600;
}

.main {
  padding: 16px;
  overflow: auto;
}
</style>
