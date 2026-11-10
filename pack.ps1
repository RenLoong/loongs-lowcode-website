# Windows pack for loongs-lowcode-website (run in PowerShell from website root).
# Builds the Vue production bundle, then publishes it to Showcase public/web.
#
# Destination cleanup is explicit: empty ONLY the contents of
#   lowcode\server\apps\Showcase\public\web
# before copying. The web directory itself and all parent dirs
# (public, Showcase, apps, ...) are left in place and never deleted.
#
# Linux/macOS: ./pack.sh
#
#   .\pack.ps1
#   .\pack.ps1 -Base /showcase/web/

[CmdletBinding()]
param(
    [string]$Base = '/showcase/web/'
)

$ErrorActionPreference = 'Stop'
$WebsiteRoot = $PSScriptRoot
$DistDir = Join-Path $WebsiteRoot 'dist'
$PublicWeb = [System.IO.Path]::GetFullPath((Join-Path $WebsiteRoot '..\server\apps\Showcase\public\web'))

function Write-Step([string]$msg) {
    Write-Host ''
    Write-Host "==> $msg" -ForegroundColor Cyan
}

Push-Location $WebsiteRoot
try {
    Write-Step "npm run build -- --base $Base"
    npm run build -- --base $Base
    if ($LASTEXITCODE -ne 0) { throw "npm run build failed ($LASTEXITCODE)" }

    if (-not (Test-Path (Join-Path $DistDir 'index.html'))) {
        throw 'missing dist/index.html (expected Vite output in dist/)'
    }

    # Empty destination web dir contents only. Do not Remove-Item the web
    # directory itself, and do not delete any parent directory.
    Write-Step "Empty $PublicWeb (contents only; keep the web directory and parents)"
    New-Item -ItemType Directory -Force -Path $PublicWeb | Out-Null
    Get-ChildItem -Force $PublicWeb -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force

    Write-Step "Copy dist/ -> $PublicWeb"
    Copy-Item (Join-Path $DistDir '*') $PublicWeb -Recurse -Force
    Write-Host "OK $PublicWeb"
} finally {
    Pop-Location
}
