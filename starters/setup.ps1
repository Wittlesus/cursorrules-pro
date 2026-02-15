# Setup script for CursorRules Pro starters (PowerShell version)
# Usage: .\setup.ps1 <starter-type> <target-directory>
#
# Example: .\setup.ps1 nextjs-saas C:\Projects\my-saas-project

param(
    [Parameter(Mandatory=$true)]
    [string]$StarterType,

    [Parameter(Mandatory=$true)]
    [string]$TargetDir
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Print-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Print-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Blue
}

function Print-Warning {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Print-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Show-Usage {
    Write-Host "CursorRules Pro — Starter Setup Script"
    Write-Host ""
    Write-Host "Usage: .\setup.ps1 <starter-type> <target-directory>"
    Write-Host ""
    Write-Host "Available starters:"
    Write-Host "  nextjs-saas    Complete Next.js SaaS setup (auth, Stripe, database)"
    Write-Host "  python-api     Python FastAPI/Flask API setup"
    Write-Host "  react-native   React Native / Expo mobile app setup"
    Write-Host "  monorepo       Turborepo/Nx monorepo setup"
    Write-Host ""
    Write-Host "Example:"
    Write-Host "  .\setup.ps1 nextjs-saas C:\Projects\my-saas-project"
    Write-Host ""
}

# Validate starter type
$StarterPath = Join-Path $ScriptDir $StarterType
if (-not (Test-Path $StarterPath)) {
    Print-Error "Starter type '$StarterType' not found."
    Write-Host ""
    Show-Usage
    exit 1
}

# Create target directory if it doesn't exist
if (-not (Test-Path $TargetDir)) {
    Print-Warning "Target directory does not exist. Creating: $TargetDir"
    New-Item -ItemType Directory -Path $TargetDir | Out-Null
}

Print-Info "Setting up $StarterType in $TargetDir"
Write-Host ""

# Copy .cursorrules
$CursorRulesSource = Join-Path $StarterPath ".cursorrules"
if (Test-Path $CursorRulesSource) {
    Copy-Item $CursorRulesSource -Destination (Join-Path $TargetDir ".cursorrules")
    Print-Success "Copied .cursorrules"
}

# Copy CLAUDE.md
$ClaudeMdSource = Join-Path $StarterPath "CLAUDE.md"
if (Test-Path $ClaudeMdSource) {
    Copy-Item $ClaudeMdSource -Destination (Join-Path $TargetDir "CLAUDE.md")
    Print-Success "Copied CLAUDE.md"
}

# Copy .vscode settings (if exists)
$VSCodeSource = Join-Path $StarterPath ".vscode"
if (Test-Path $VSCodeSource) {
    $VSCodeTarget = Join-Path $TargetDir ".vscode"
    if (-not (Test-Path $VSCodeTarget)) {
        New-Item -ItemType Directory -Path $VSCodeTarget | Out-Null
    }
    Copy-Item -Path "$VSCodeSource\*" -Destination $VSCodeTarget -Recurse -Force
    Print-Success "Copied .vscode settings"
}

# Copy pre-commit hook (if exists)
$PreCommitSource = Join-Path $StarterPath "pre-commit"
if (Test-Path $PreCommitSource) {
    $GitHooksDir = Join-Path $TargetDir ".git\hooks"
    if (Test-Path (Join-Path $TargetDir ".git")) {
        if (-not (Test-Path $GitHooksDir)) {
            New-Item -ItemType Directory -Path $GitHooksDir | Out-Null
        }
        Copy-Item $PreCommitSource -Destination (Join-Path $GitHooksDir "pre-commit")
        Print-Success "Installed pre-commit hook"
    } else {
        Print-Warning "No .git directory found. Pre-commit hook not installed."
        Print-Info "Copy manually to .git/hooks/pre-commit when you initialize git."
    }
}

# Copy Makefile (if exists)
$MakefileSource = Join-Path $StarterPath "Makefile"
if (Test-Path $MakefileSource) {
    Copy-Item $MakefileSource -Destination (Join-Path $TargetDir "Makefile")
    Print-Success "Copied Makefile"
}

Write-Host ""
Print-Success "Setup complete!"
Write-Host ""
Print-Info "Next steps:"

switch ($StarterType) {
    "nextjs-saas" {
        Write-Host "  1. Update CLAUDE.md with your project details"
        Write-Host "  2. Customize .cursorrules with project-specific rules"
        Write-Host "  3. Set up environment variables in .env.local"
        Write-Host "  4. Run: npm install"
        Write-Host "  5. Run: npx prisma migrate dev"
        Write-Host "  6. Start coding with AI assistance!"
    }
    "python-api" {
        Write-Host "  1. Update CLAUDE.md with your project details"
        Write-Host "  2. Customize .cursorrules with project-specific rules"
        Write-Host "  3. Set up environment variables in .env"
        Write-Host "  4. Run: poetry install (or pip install -r requirements.txt)"
        Write-Host "  5. Run: alembic upgrade head"
        Write-Host "  6. Start coding with AI assistance!"
    }
    "react-native" {
        Write-Host "  1. Update CLAUDE.md with your project details"
        Write-Host "  2. Customize .cursorrules with project-specific rules"
        Write-Host "  3. Set up environment variables in .env"
        Write-Host "  4. Run: npm install"
        Write-Host "  5. Run: npx expo start"
        Write-Host "  6. Start coding with AI assistance!"
    }
    "monorepo" {
        Write-Host "  1. Update CLAUDE.md with your monorepo structure"
        Write-Host "  2. Customize .cursorrules for your packages and apps"
        Write-Host "  3. Set up pnpm workspace: pnpm install"
        Write-Host "  4. Configure turbo.json for your pipeline"
        Write-Host "  5. Start coding with AI assistance!"
    }
}

Write-Host ""
Print-Info "Files installed:"
Write-Host "  - .cursorrules (AI coding rules for your stack)"
Write-Host "  - CLAUDE.md (project context for AI)"
if (Test-Path (Join-Path $TargetDir ".vscode")) {
    Write-Host "  - .vscode/settings.json (recommended VS Code settings)"
}
if (Test-Path (Join-Path $TargetDir ".git\hooks\pre-commit")) {
    Write-Host "  - .git/hooks/pre-commit (AI-assisted code review)"
}
if (Test-Path (Join-Path $TargetDir "Makefile")) {
    Write-Host "  - Makefile (common commands with AI context)"
}

Write-Host ""
Print-Info "Compatible with: Cursor, Cline, Claude Code, GitHub Copilot, Windsurf"
Write-Host ""
