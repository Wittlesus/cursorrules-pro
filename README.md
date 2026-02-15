# AI Dev Config Toolkit — Production Configs for Every AI Coding Tool

**Stop configuring your AI coding tools. Start shipping.**

awesome-cursorrules gives you Cursor rules. We give you complete production configs for EVERY AI coding tool, plus advanced starters and automation tools.

The only AI coding config pack with:
- **8 stack-specific configs** for Cursor, Claude Code, Windsurf & Copilot
- **4 advanced project starters** (Next.js SaaS, Python API, React Native, Monorepo)
- **Auto-generation tools** that scan your project and create configs automatically

## Pricing

**$14 — One-time purchase. Not a subscription.**

[**Buy Now**](https://buy.stripe.com/8x24gydPfeFY1AU5Bo08g05)

What you get:
- **8 stack-specific configs** — Next.js, React Native, FastAPI, Express, Rust, Go, SvelteKit, Django
- **4 advanced starters** — Complete configs for Next.js SaaS, Python API, React Native, Monorepo
- **Auto-generation tools** — Scan projects and create CLAUDE.md automatically
- **Migration tools** — Convert between .cursorrules and CLAUDE.md formats
- **Setup scripts** — One-command install for any starter (Bash + PowerShell)
- Works with all major AI tools: Cursor, Cline, Claude Code, GitHub Copilot, Windsurf
- Lifetime updates as stacks evolve

**Save $119:** Get this + 6 other products in the [Complete Bundle for $99](https://buy.stripe.com/5kQeVceTj0P8enGe7U08g06)

---

## Why This vs Free Alternatives

| Feature | awesome-cursorrules (free) | cursor.directory (free) | AI Dev Config Toolkit ($14) |
|---------|---------------------------|-------------------------|------------------------------|
| Cursor rules | Yes | Yes | Yes |
| CLAUDE.md templates | No | No | Yes |
| Windsurf configs | No | No | Yes |
| Copilot instructions | No | No | Yes |
| Advanced starters | No | No | **Yes (4 types)** |
| Setup scripts | No | No | **Yes (Bash + PowerShell)** |
| Auto-generators | No | No | **Yes** |
| Migration tools | No | No | **Yes** |
| Production-tested | Sometimes | Sometimes | Always |
| Framework-current | Varies | Varies | Yes (Next.js 14+, Svelte 5, Pydantic v2, etc.) |
| Length/Depth | 10-20 lines | 10-30 lines | 50-130 lines |
| Multi-tool support | No | No | Yes |

**The difference:** Free alternatives give you basic Cursor rules. We give you complete configuration coverage across all major AI coding tools, with deep, opinionated guidance that actually changes AI output quality.

---

## What's Included

### 8 Stack-Specific Config Sets

Each stack includes configs for **all 4 major AI coding tools**:

| Stack | Coverage | Key Topics |
|-------|----------|------------|
| **Next.js + TypeScript** | `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md` | App Router, Server/Client Components, Server Actions, Tailwind, Zod validation |
| **React Native / Expo** | Full multi-tool configs | Expo Router, FlatList, Zustand, native modules, platform-specific code |
| **Python FastAPI** | Full multi-tool configs | Async patterns, Pydantic v2, SQLAlchemy 2.0, dependency injection, JWT auth |
| **Node.js Express** | Full multi-tool configs | Middleware patterns, Zod validation, Prisma/Drizzle, JWT auth, error handling |
| **Rust** | Full multi-tool configs | Ownership, lifetimes, error handling with thiserror/anyhow, async with tokio, traits |
| **Go (Golang)** | Full multi-tool configs | Error wrapping, goroutines, interfaces, context, table-driven tests |
| **SvelteKit** | Full multi-tool configs | Svelte 5 runes, load functions, form actions, SSR, stores |
| **Django** | Full multi-tool configs | Models, DRF serializers, signals, Celery, pytest-django, factory_boy |

### 4 Advanced Project Starters

Complete, opinionated configs that go beyond basic stack rules:

#### 1. Next.js SaaS Starter
- `.cursorrules` with SaaS-specific patterns (auth, Stripe, database)
- `CLAUDE.md` with project structure, key files, deployment notes
- `.vscode/settings.json` with recommended extensions
- Pre-commit hook for AI-assisted code review
- **Covers:** NextAuth.js, Stripe webhooks, Prisma, Server Actions, RBAC

#### 2. Python API Starter
- `.cursorrules` for FastAPI/Flask production patterns
- `CLAUDE.md` with API structure and conventions
- `Makefile` with documented commands (dev, test, migrate)
- **Covers:** SQLAlchemy 2.0 async, JWT auth, Pydantic v2, Alembic

#### 3. React Native Starter
- `.cursorrules` for mobile-specific patterns
- `CLAUDE.md` with navigation structure, platform differences
- **Covers:** Expo Router, TanStack Query, Zustand, push notifications, EAS

#### 4. Monorepo Starter
- `.cursorrules` for Turborepo/Nx patterns
- `CLAUDE.md` with workspace structure, task pipeline
- **Covers:** pnpm workspaces, cross-package imports, caching, versioning

**One-command setup:**
```bash
./starters/setup.sh nextjs-saas /path/to/project  # Bash
.\starters\setup.ps1 nextjs-saas C:\path\to\project  # PowerShell
```

### Automation Tools

#### `generate-claude-md.sh`
Auto-generates CLAUDE.md from your project:
- Detects tech stack (package.json, requirements.txt, etc.)
- Extracts commands from package.json and Makefile
- Generates project structure tree
- Identifies key files

```bash
./tools/generate-claude-md.sh /path/to/project
```

#### `migrate-cursorrules.sh`
Converts between .cursorrules and CLAUDE.md formats:
- Auto-detects conversion direction
- Preserves formatting
- Shows compatibility info

```bash
./tools/migrate-cursorrules.sh .cursorrules CLAUDE.md
./tools/migrate-cursorrules.sh CLAUDE.md .cursorrules
```

---

## Quick Start

### Option 1: Use an Advanced Starter (Recommended)

For new projects or major setup:

```bash
# Bash (Linux/macOS/Git Bash on Windows)
./starters/setup.sh nextjs-saas /path/to/my-project

# PowerShell (Windows)
.\starters\setup.ps1 nextjs-saas C:\path\to\my-project
```

Available starters: `nextjs-saas`, `python-api`, `react-native`, `monorepo`

This installs:
- `.cursorrules` with stack-specific rules
- `CLAUDE.md` with project structure and context
- `.vscode/settings.json` (for applicable starters)
- Pre-commit hooks (for applicable starters)
- Makefile (for Python API)

### Option 2: Auto-Generate from Existing Project

For existing projects:

```bash
./tools/generate-claude-md.sh /path/to/project
```

This scans your project and creates a basic `CLAUDE.md` with:
- Detected tech stack
- Project structure
- Key commands
- Key files

### Option 3: Manual Setup (Stack-Specific Rules)

#### For Cursor

1. Copy the `.cursorrules` file for your stack from `rules/` into your project root.
2. Open your project in Cursor. The rules are active immediately.

#### For Claude Code

1. Copy the `CLAUDE.md` template from a starter or use the auto-generator.
2. Claude Code will auto-detect it.

#### For Windsurf

1. Copy the `.cursorrules` file and rename it to `.windsurfrules`.
2. Place in your project root. Reload Windsurf to activate.

#### For GitHub Copilot

1. Create a `.github/` directory in your project root (if it doesn't exist).
2. Copy your `.cursorrules` content into `.github/copilot-instructions.md`.

### Option 4: Convert Between Formats

Already have a `.cursorrules` file? Convert it:

```bash
./tools/migrate-cursorrules.sh .cursorrules CLAUDE.md
```

Or convert from CLAUDE.md to .cursorrules:

```bash
./tools/migrate-cursorrules.sh CLAUDE.md .cursorrules
```

---

## All Supported AI Coding Tools

| Tool | Config File | Location | Format |
|------|-------------|----------|--------|
| **Cursor** | `.cursorrules` | Project root | Plain text |
| **Cline** | `.clinerules` | Project root | Plain text |
| **Claude Code** | `CLAUDE.md` | Project root | Markdown |
| **GitHub Copilot** | `copilot-instructions.md` | `.github/` directory | Markdown |
| **Windsurf** | `.windsurfrules` | Project root | Plain text |

---

## Customization Guide

These configs are designed as a strong starting point. Customize them for your team:

### Adding Your Conventions

Add a section at the top of each config file with your project-specific rules:

```
## Our Project
- We use pnpm, not npm or yarn.
- Our API base URL is defined in `@/lib/api.ts`.
- All components must have a corresponding Storybook story.
- We follow the Conventional Commits spec for all commit messages.
```

### Modifying Existing Rules

Every rule is a plain-text line. Edit, delete, or reorder as needed:

- **Remove** rules that conflict with your team's conventions.
- **Strengthen** rules by adding "ALWAYS" or "NEVER" for critical patterns.
- **Add examples** — AI assistants perform better with concrete code samples.

### Combining Stacks

For full-stack projects, use the provided starter templates or merge configs manually:

```
# Frontend: Next.js + TypeScript
[paste nextjs-typescript rules]

# Backend: Python FastAPI
[paste python-fastapi rules]

# Shared Rules
- Use absolute imports everywhere
- All API responses must match our ResponseSchema type
```

### Team Sharing

Commit the config files to your repo so every team member gets the same AI behavior. Include them in your onboarding documentation.

---

## Why This Works

AI coding assistants generate better code when they understand your project's conventions. Without explicit rules, they:

- Mix framework versions (Pages Router vs App Router)
- Use deprecated patterns (class components, Svelte 4 syntax)
- Ignore your project structure (dumping everything in one file)
- Skip error handling and validation
- Write untestable code
- Switch between coding styles mid-generation

AI Dev Config Toolkit encodes years of production experience into concise instructions that keep your AI assistant on track, regardless of which tool you use.

---

## What's Different About These Configs

- **Production-tested** — Every rule comes from real-world projects, not documentation summaries.
- **Framework-current** — Updated for Next.js 14+, Svelte 5, Pydantic v2, SQLAlchemy 2.0, Go 1.22+.
- **Opinionated** — Clear guidance, not wishy-washy suggestions. Your AI needs direction.
- **Concise** — 50-100 lines each. Long enough to be comprehensive, short enough for the AI context window.
- **Multi-tool native** — Not just Cursor rules renamed. Each tool gets optimized formatting.
- **Immediately usable** — Copy, paste, code. No configuration needed.

---

## Project Types Covered

### Web Applications
- Next.js (App Router + TypeScript)
- SvelteKit (Svelte 5)
- Django (with Django REST Framework)

### Mobile
- React Native (with Expo)

### Backend APIs
- Python FastAPI
- Node.js Express
- Go (standard library + gorilla/mux)

### Systems Programming
- Rust (tokio async runtime)

### Full-Stack Combinations
All combinations of the above via starter templates and the auto-generator.

---

## Auto-Generator Details

The included auto-generator (`bin/generate.js`) provides:

**Stack Detection:**
- Analyzes `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`
- Detects framework from dependencies
- Identifies monorepo structures

**Interactive Selection:**
- Confirms detected stack
- Asks which AI tools you use
- Offers to install configs for all or selected tools

**Smart Installation:**
- Creates necessary directories (`.github/`)
- Handles existing configs (backup before overwrite)
- Sets correct permissions on Unix systems
- Validates syntax after installation

**Output:**
```
Detected stack: Next.js 14 + TypeScript
AI tools in use: Cursor, Claude Code

Installing configs:
  ✓ .cursorrules
  ✓ CLAUDE.md

Done! Your AI tools are now configured for Next.js best practices.
```

---

## More Developer Tools

| Product | Description | Price |
|---------|-------------|-------|
| [LaunchFast SaaS Starter](https://github.com/Wittlesus/launchfast-starter) | Next.js 16 boilerplate with auth, payments, AI, email | $79 |
| [PageBrain Extension](https://github.com/Wittlesus/pagebrain-extension) | Summarize any page with AI (Chrome) | Free |
| [SEO Blog Engine](https://github.com/Wittlesus/seo-blog-engine) | CLI for generating SEO blog posts | $29 |
| [Indie Hacker Toolkit](https://github.com/Wittlesus/indie-hacker-toolkit) | 5 planning templates for solo founders | $19 |
| [PromptVault](https://github.com/Wittlesus/prompt-vault) | 64 production-ready AI prompts | $19 |
| [Complete Bundle](https://buy.stripe.com/5kQeVceTj0P8enGe7U08g06) | All products above | $99 |

---

## License

For personal and commercial use. You may use these configs in any project. You may not redistribute or resell the config collection itself.

---

**Built for developers who want their AI to write code the right way, the first time — no matter which AI coding tool they use.**
