# AI Dev Config Toolkit — Production Configs for Cursor, Claude Code, Windsurf & Copilot

**Stop configuring your AI coding tools. Start shipping.**

awesome-cursorrules gives you Cursor rules. We give you production configs for EVERY AI coding tool.

The only AI coding config pack that covers all 4 major AI coding tools with project-specific starters and auto-generators.

## Pricing

**$14 — One-time purchase. Not a subscription.**

[**Buy Now**](https://buy.stripe.com/8x24gydPfeFY1AU5Bo08g05)

What you get:
- 8 production-tested config sets for popular stacks
- Works with Cursor, Claude Code, Windsurf, GitHub Copilot
- CLAUDE.md templates, Windsurf configs, Copilot instructions
- Auto-generator scripts for new project types
- Customization guide and team sharing instructions
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
| Project-type starters | No | No | Yes |
| Setup scripts | No | No | Yes |
| Auto-generators | No | No | Yes |
| Production-tested | Sometimes | Sometimes | Always |
| Framework-current | Varies | Varies | Yes (Next.js 14+, Svelte 5, etc.) |
| Length/Depth | 10-20 lines | 10-30 lines | 50-100 lines |
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

### Project-Type Starters

Pre-configured starter templates for:
- Full-stack monorepos (Next.js + FastAPI)
- Mobile apps (React Native + Express API)
- Microservices (Go + Python)
- Real-time apps (SvelteKit + WebSockets)

### Auto-Generator Scripts

Quick-start scripts that:
1. Detect your project's tech stack
2. Generate appropriate configs for all 4 AI tools
3. Install them in the correct locations
4. Validate compatibility

---

## Quick Start

### For Cursor

1. Copy the `.cursorrules` file for your stack into your project root.
2. Rename it to `.cursorrules` (if not already).
3. Open your project in Cursor. The rules are active immediately.

### For Claude Code

1. Copy the `CLAUDE.md` file for your stack into your project root.
2. That's it. Claude Code will auto-detect it.

### For Windsurf

1. Copy the `.windsurfrules` file for your stack into your project root.
2. Reload Windsurf to activate.

### For GitHub Copilot

1. Create a `.github/` directory in your project root (if it doesn't exist).
2. Copy the `copilot-instructions.md` file into `.github/copilot-instructions.md`.
3. Copilot will use it for all suggestions in that repo.

### Using the Auto-Generator (Recommended)

```bash
# Run the generator in your project directory
node path/to/ai-dev-config-toolkit/bin/generate.js

# It will:
# 1. Detect your stack (by analyzing package.json, requirements.txt, etc.)
# 2. Ask which AI tools you use
# 3. Install the appropriate configs
# 4. Show you what it created
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
