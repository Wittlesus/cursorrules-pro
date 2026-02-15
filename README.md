# AI Dev Config Toolkit — Cursor + Claude Code + Windsurf + Copilot

**The only config pack that covers ALL major AI coding assistants.**

awesome-cursorrules has 37,800 stars but ZERO CLAUDE.md templates. cursor.directory has thousands of rules but zero Windsurf or Copilot configs. We give you **complete coverage** across Cursor, Claude Code, Windsurf, and GitHub Copilot.

## Pricing

**$14 — One-time purchase. Not a subscription.**

[**Buy Now**](https://buy.stripe.com/8x24gydPfeFY1AU5Bo08g05)

What you get:
- **5 project type configs** — SaaS, API, Mobile, CLI, Data Science
- **Each type includes 4 files** — `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md`
- **Plus 8 legacy stack configs** — Next.js, React Native, FastAPI, Express, Rust, Go, SvelteKit, Django
- Works with all major AI tools: Cursor, Cline, Claude Code, GitHub Copilot, Windsurf
- Lifetime updates as AI tools and frameworks evolve

**Save $119:** Get this + 6 other products in the [Complete Bundle for $99](https://buy.stripe.com/5kQeVceTj0P8enGe7U08g06)

---

## Why This vs Free Alternatives

| Feature | awesome-cursorrules | cursor.directory | AI Dev Config Toolkit |
|---------|---------------------|------------------|----------------------|
| Cursor rules | ✅ Yes | ✅ Yes | ✅ Yes |
| **CLAUDE.md templates** | ❌ No | ❌ No | ✅ **YES** |
| Windsurf configs | ❌ No | ❌ No | ✅ **YES** |
| Copilot instructions | ❌ No | ❌ No | ✅ **YES** |
| Project type coverage | Stack-focused | Stack-focused | **Project-focused** |
| Depth | 10-30 lines | 10-50 lines | 50-150 lines |
| Production-tested | Varies | Varies | Always |
| Multi-tool support | No | No | **Full coverage** |

**The key difference:** Free alternatives give you basic Cursor rules for tech stacks. We give you comprehensive configs for **project types** across **all major AI coding tools**.

---

## What's Included

### 5 Project Type Configs (NEW)

Each project type includes **4 complete config files**:

#### 1. SaaS Project Config
**Files:** `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md`

**Covers:**
- Next.js 14+ App Router architecture
- Server Components vs Client Components
- Server Actions for mutations
- TypeScript strict mode patterns
- Zod validation patterns
- Error handling and loading states
- Testing strategy (Server vs Client)
- Authentication and authorization
- Database patterns (Prisma/Drizzle)
- Deployment considerations

**Perfect for:** Next.js SaaS products, web apps, dashboards, B2B tools

---

#### 2. API Project Config
**Files:** `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md`

**Covers:**
- Clean architecture (Controllers → Services → Repositories)
- REST API design (proper HTTP methods, status codes)
- Input validation with schemas
- JWT authentication and RBAC
- Database patterns and migrations
- Error handling and logging
- Rate limiting and security
- Testing strategy (unit + integration)
- Works with: FastAPI, Express, Nest.js, Go Fiber, Actix

**Perfect for:** REST APIs, GraphQL servers, microservices, backend services

---

#### 3. Mobile Project Config
**Files:** `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md`

**Covers:**
- React Native + Expo patterns
- FlatList performance optimization
- Platform-specific code (iOS vs Android)
- Expo Router navigation
- State management (Zustand + React Query)
- Native module usage (camera, location, etc.)
- Permission handling
- Secure storage for credentials
- Testing (Jest + E2E with Maestro)
- Build and deployment (EAS)

**Perfect for:** iOS/Android apps, cross-platform mobile apps, Expo projects

---

#### 4. CLI Tool Config
**Files:** `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md`

**Covers:**
- Command structure (subcommands, flags, arguments)
- User-friendly error messages
- Progress indicators and colorized output
- Interactive prompts with defaults
- Configuration management (files + env vars)
- Secrets handling (OS keychain)
- Cross-platform compatibility
- Testing CLI commands
- Distribution (PyPI, npm, crates.io, binaries)

**Perfect for:** Developer tools, automation scripts, deployment tools, system utilities

---

#### 5. Data Science / ML Config
**Files:** `.cursorrules`, `CLAUDE.md`, `.windsurfrules`, `.github/copilot-instructions.md`

**Covers:**
- Jupyter notebook best practices
- Reproducibility (random seeds, version control)
- Data exploration and preprocessing
- Train/validation/test splits (no data leakage)
- Baseline models and proper metrics
- Model training and hyperparameter tuning
- Model evaluation and visualization
- Production deployment patterns
- Experiment tracking (MLflow, W&B)

**Perfect for:** ML projects, data analysis, predictive modeling, research notebooks

---

### 8 Legacy Stack Configs

For backwards compatibility, we include the original stack-specific configs:

| Stack | Files | Key Topics |
|-------|-------|------------|
| Next.js + TypeScript | `.cursorrules` only | App Router, Server Components, Server Actions |
| React Native / Expo | `.cursorrules` only | Expo Router, FlatList, native modules |
| Python FastAPI | `.cursorrules` only | Async, Pydantic v2, SQLAlchemy 2.0 |
| Node.js Express | `.cursorrules` only | Middleware, validation, Prisma/Drizzle |
| Rust | `.cursorrules` only | Ownership, async tokio, error handling |
| Go (Golang) | `.cursorrules` only | Goroutines, interfaces, error wrapping |
| SvelteKit | `.cursorrules` only | Svelte 5 runes, load functions, form actions |
| Django | `.cursorrules` only | DRF, Celery, pytest-django |

**Note:** These are single-file `.cursorrules` configs. For multi-tool coverage, use the project type configs above.

---

## Quick Start

### For Cursor
```bash
# Copy the .cursorrules file for your project type
cp config-templates/saas/.cursorrules /path/to/your/project/
# Restart Cursor or reload window
```

### For Claude Code CLI
```bash
# Copy the CLAUDE.md file for your project type
cp config-templates/saas/CLAUDE.md /path/to/your/project/
# Claude Code automatically reads CLAUDE.md files
```

### For Windsurf
```bash
# Copy the .windsurfrules file for your project type
cp config-templates/saas/.windsurfrules /path/to/your/project/
# Windsurf automatically detects and applies the rules
```

### For GitHub Copilot
```bash
# Create .github directory if it doesn't exist
mkdir -p /path/to/your/project/.github
# Copy the copilot-instructions.md file
cp config-templates/saas/.github/copilot-instructions.md /path/to/your/project/.github/
# Copilot will use these instructions for all suggestions
```

---

## File Format Compatibility

| Tool | File Name | Format |
|------|-----------|--------|
| Cursor | `.cursorrules` | Plain text |
| Cline | `.clinerules` | Plain text (same content as .cursorrules) |
| Claude Code | `CLAUDE.md` | Markdown with project context |
| GitHub Copilot | `.github/copilot-instructions.md` | Markdown |
| Windsurf | `.windsurfrules` | Plain text |

---

## What Makes CLAUDE.md Different?

**CLAUDE.md files are project-specific instruction files for Claude Code CLI** — Anthropic's official CLI for Claude that's blowing up among developers.

### Why They're Powerful

1. **Project context** — Not just coding rules, but project structure, tech stack, deployment notes
2. **Key commands** — Document your project's npm scripts, CLI commands, deployment steps
3. **Common patterns** — Show the AI how YOUR project does auth, database access, API calls
4. **Troubleshooting** — Pre-answer common questions (how to fix build errors, where are logs, etc.)

### Example CLAUDE.md Features
```markdown
## Tech Stack
- Framework: Next.js 14 (App Router)
- Database: PostgreSQL with Prisma
- Auth: NextAuth.js with Google OAuth
- Payments: Stripe with webhooks

## Key Commands
npm run dev          # Start dev server
npm run db:migrate   # Run Prisma migrations
npm run test         # Run tests

## Common Patterns
// Server Action for mutations
'use server';
export async function updateProfile(formData: FormData) {
  // validate, update DB, revalidate
}

## Troubleshooting
- Build fails: Check .env.local has all required vars
- DB errors: Run `npm run db:migrate`
```

**No free collection offers this.** awesome-cursorrules: 37,800 stars, zero CLAUDE.md templates.

---

## Customization Guide

These configs are production-ready starting points. Customize them for your team:

### Add Your Project Details
```markdown
## Our Project
- Name: MyApp
- Tech: Next.js 14, Prisma, NextAuth, Stripe
- Database: PostgreSQL on Supabase
- Hosting: Vercel
- Monitoring: Sentry
```

### Add Your Conventions
```markdown
## Our Team Conventions
- We use pnpm, not npm
- API routes are prefixed with /api/v1/
- All PRs require 2 approvals
- We use Shadcn UI for components
- We write JSDoc comments on all utils
```

### Strengthen Critical Rules
```markdown
## NEVER VIOLATE
- ALWAYS validate user input with Zod
- NEVER commit .env files
- ALWAYS write tests for Server Actions
- NEVER use `any` type in TypeScript
```

---

## Benefits Over Generic Configs

### Project-Focused, Not Stack-Focused
Free alternatives organize by tech stack (Next.js, React, Python). We organize by **project type** (SaaS, API, Mobile, CLI, Data Science). This gives you configs that understand your **use case**, not just your framework.

### Multi-Tool Coverage
You don't just use Cursor. Maybe you use Claude Code in the terminal, Copilot in VS Code, and Windsurf for experiments. Free alternatives only give you `.cursorrules`. We give you configs for **all major AI tools**.

### CLAUDE.md Templates (Unique)
Claude Code is blowing up, but NO free collection offers `CLAUDE.md` templates. We're the first to provide comprehensive project-specific CLAUDE.md files with tech stack docs, common patterns, and troubleshooting.

### Production-Tested Depth
Free configs are often 10-30 lines of generic advice. Ours are 50-150 lines of battle-tested patterns from real production projects. We cover:
- Architecture patterns
- Error handling
- Testing strategies
- Performance optimization
- Security best practices
- Deployment considerations

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

**Built for developers who want their AI coding tools to understand their project from day one.**

**Questions?** GitHub issues: github.com/Wittlesus/cursorrules-pro
