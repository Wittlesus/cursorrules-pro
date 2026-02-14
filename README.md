# CursorRules Pro — AI Coding Rules for Every Stack

**Stop fighting your AI assistant. Make it understand your stack.**

CursorRules Pro is a curated collection of `.cursorrules` files optimized for the most popular tech stacks. Drop one into your project and instantly get better code suggestions, fewer hallucinations, and AI output that actually follows your framework's best practices.

Works with **Cursor**, **Cline** (`.clinerules`), **Claude Code** (`CLAUDE.md`), and any AI coding tool that supports project-level instructions.

---

## What's Included

| Stack | File | Key Topics |
|-------|------|------------|
| **Next.js + TypeScript** | `rules/nextjs-typescript/.cursorrules` | App Router, Server/Client Components, Server Actions, Tailwind, Zod validation |
| **React Native / Expo** | `rules/react-native/.cursorrules` | Expo Router, FlatList, Zustand, native modules, platform-specific code |
| **Python FastAPI** | `rules/python-fastapi/.cursorrules` | Async patterns, Pydantic v2, SQLAlchemy 2.0, dependency injection, JWT auth |
| **Node.js Express** | `rules/node-express/.cursorrules` | Middleware patterns, Zod validation, Prisma/Drizzle, JWT auth, error handling |
| **Rust** | `rules/rust/.cursorrules` | Ownership, lifetimes, error handling with thiserror/anyhow, async with tokio, traits |
| **Go (Golang)** | `rules/golang/.cursorrules` | Error wrapping, goroutines, interfaces, context, table-driven tests |
| **SvelteKit** | `rules/svelte-kit/.cursorrules` | Svelte 5 runes, load functions, form actions, SSR, stores |
| **Django** | `rules/django/.cursorrules` | Models, DRF serializers, signals, Celery, pytest-django, factory_boy |

---

## Quick Start

### For Cursor

1. Copy the `.cursorrules` file for your stack into your project root.
2. Rename it to `.cursorrules` (if not already).
3. Open your project in Cursor. The rules are active immediately.

### For Cline

1. Copy the file and rename it to `.clinerules`.
2. Place it in your project root.

### For Claude Code

1. Copy the file content into a `CLAUDE.md` file in your project root.

### For Other AI Tools

Most AI coding tools support a project-level instruction file. Copy the content into whatever file your tool uses (`.github/copilot-instructions.md`, `.ai/rules`, etc.).

---

## Customization Guide

These rules are designed as a strong starting point. Customize them for your team:

### Adding Your Conventions

Add a section at the top of the file with your project-specific rules:

```
## Our Project
- We use pnpm, not npm or yarn.
- Our API base URL is defined in `@/lib/api.ts`.
- All components must have a corresponding Storybook story.
```

### Modifying Existing Rules

Every rule is a plain-text line. Edit, delete, or reorder as needed:

- **Remove** rules that conflict with your team's conventions.
- **Strengthen** rules by adding "ALWAYS" or "NEVER" for critical patterns.
- **Add examples** — AI assistants perform better with concrete code samples.

### Combining Stacks

For full-stack projects, merge rules from multiple files:

```
# Frontend: Next.js + TypeScript
[paste nextjs-typescript rules]

# Backend: Python FastAPI
[paste python-fastapi rules]
```

### Team Sharing

Commit the rules file to your repo so every team member gets the same AI behavior. Include it in your onboarding documentation.

---

## Why This Works

AI coding assistants generate better code when they understand your project's conventions. Without explicit rules, they:

- Mix framework versions (Pages Router vs App Router)
- Use deprecated patterns (class components, Svelte 4 syntax)
- Ignore your project structure (dumping everything in one file)
- Skip error handling and validation
- Write untestable code

CursorRules Pro encodes years of production experience into concise instructions that keep your AI assistant on track.

---

## What's Different About These Rules

- **Production-tested** — Every rule comes from real-world projects, not documentation summaries.
- **Framework-current** — Updated for Next.js 14+, Svelte 5, Pydantic v2, SQLAlchemy 2.0, Go 1.22+.
- **Opinionated** — Clear guidance, not wishy-washy suggestions. Your AI needs direction.
- **Concise** — 50-100 lines each. Long enough to be comprehensive, short enough for the AI context window.
- **Immediately usable** — Copy, paste, code. No configuration needed.

---

## File Format Compatibility

| Tool | File Name | Format |
|------|-----------|--------|
| Cursor | `.cursorrules` | Plain text (as provided) |
| Cline | `.clinerules` | Plain text (same content) |
| Claude Code | `CLAUDE.md` | Markdown (same content) |
| GitHub Copilot | `.github/copilot-instructions.md` | Markdown (same content) |
| Windsurf | `.windsurfrules` | Plain text (same content) |

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

For personal and commercial use. You may use these rules in any project. You may not redistribute or resell the rules collection itself.

---

**Built for developers who want their AI to write code the right way, the first time.**
