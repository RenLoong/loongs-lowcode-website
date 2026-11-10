# loongs-lowcode-website

LOONGS 低代码 **Web PC** 站点。

本仓库只负责浏览器端 PC Web，不打包桌面或移动端。
原生 / 平板客户端见 [loongs-lowcode-client](https://github.com/RenLoong/loongs-lowcode-client)（Windows、Linux、macOS、Android 平板、iOS 平板，不构建 Web）。

业务逻辑后续可与 Flutter client 对齐；当前仅为可运行骨架，不含产品功能。

## 技术栈

- Vue 3
- Vite
- TypeScript（strict）
- Element Plus（中文语言包 zh-CN）+ 官方图标
- Vue Router
- Pinia
- Axios

## 环境变量

复制 `.env.example` 为 `.env` 或 `.env.local` 后按需修改。

| 变量 | 说明 |
|------|------|
| `VITE_API_BASE_URL` | 后端 API 基址。可用 `{host}` 表示当前页面主机名，例如 `http://{host}:21000`。默认 `http://127.0.0.1:21000`。 |

运行时也可注入 `window.__LOONGS_API_BASE_URL__`（与 Flutter client 的 domain 注入同一约定），优先于环境变量。可在 `index.html` 中取消注释示例脚本。

## 使用

```sh
npm install
npm run dev
```

开发服务器默认地址通常是 http://localhost:5173 。

| 脚本 | 说明 |
|------|------|
| `npm run dev` | 本地开发 |
| `npm run build` | 类型检查 + 生产构建 |
| `npm run preview` | 预览生产构建 |
| `npm run lint` | ESLint / Oxlint |
| `npm run format` | Prettier |
| `.\pack.ps1` / `./pack.sh` | 生产构建并发布到 Showcase `public/web` |

## 打包发布

在 website 根目录执行：

```powershell
# Windows
.\pack.ps1
```

```sh
# Linux / macOS
./pack.sh
```

脚本会先执行 `npm run build`（默认 `--base /showcase/web/`，与 Showcase 现有静态入口一致），然后**清空** `lowcode/server/apps/Showcase/public/web` 目录内的全部内容，再将 `dist/` 复制进去。

只清理该 `web` 目录中的文件和子目录，不会删除 `web` 目录本身，也不会删除其上级目录（`public`、`Showcase`、`apps` 等）。

可用 `-Base` / `--base` 覆盖资源前缀，例如：

```powershell
.\pack.ps1 -Base /showcase/web/
```

```sh
./pack.sh --base /showcase/web/
```
