<script setup lang="ts">
import { useAppStore } from '@/stores/app'

const app = useAppStore()
</script>

<template>
  <el-card shadow="never">
    <template #header>首页</template>
    <p>这是 Web PC 站点骨架，业务能力后续可与 Flutter client 对齐。</p>
    <p>当前不含产品功能。</p>
    <el-descriptions :column="1" border class="meta">
      <el-descriptions-item label="API 基址">{{ app.apiBaseUrl }}</el-descriptions-item>
    </el-descriptions>
  </el-card>
</template>

<style scoped>
p {
  margin: 0 0 12px;
  line-height: 1.6;
}

.meta {
  margin-top: 8px;
  max-width: 720px;
}
</style>
