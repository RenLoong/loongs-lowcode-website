#!/usr/bin/env bash
# Linux / macOS pack for loongs-lowcode-website (run from website root).
# Builds the Vue production bundle, then publishes it to Showcase public/web.
#
# Destination cleanup is explicit: empty ONLY the contents of
#   lowcode/server/apps/Showcase/public/web
# before copying. The web directory itself and all parent dirs
# (public, Showcase, apps, ...) are left in place and never deleted.
#
# Windows: .\pack.ps1
#
#   ./pack.sh
#   ./pack.sh --base /showcase/web/

set -euo pipefail

BASE="${BASE:-/showcase/web/}"

die() { echo "$*" >&2; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --base) BASE="$2"; shift 2 ;;
    -h|--help)
      sed -n '2,16p' "$0"
      exit 0
      ;;
    *) die "unknown arg: $1" ;;
  esac
done

WEBSITE_ROOT="$(cd "$(dirname "$0")" && pwd)"
DIST_DIR="$WEBSITE_ROOT/dist"
PUBLIC_WEB="$(cd "$WEBSITE_ROOT/.." && pwd)/server/apps/Showcase/public/web"

step() { printf '\n==> %s\n' "$*"; }

cd "$WEBSITE_ROOT"

step "npm run build -- --base $BASE"
npm run build -- --base "$BASE"

[[ -f "$DIST_DIR/index.html" ]] || die 'missing dist/index.html (expected Vite output in dist/)'

# Empty destination web dir contents only. Do not rm the web directory
# itself, and do not delete any parent directory.
step "Empty $PUBLIC_WEB (contents only; keep the web directory and parents)"
mkdir -p "$PUBLIC_WEB"
find "$PUBLIC_WEB" -mindepth 1 -maxdepth 1 -exec rm -rf {} +

step "Copy dist/ -> $PUBLIC_WEB"
cp -a "$DIST_DIR"/. "$PUBLIC_WEB"/
echo "OK $PUBLIC_WEB"
