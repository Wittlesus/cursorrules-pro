# Gumroad Product Listing: AI Dev Config Toolkit

---

## Product Name
AI Dev Config Toolkit — Production Configs for Cursor, Claude Code, Windsurf & Copilot

## Tagline
Stop configuring your AI coding tools. Start shipping.

## Price
$14 (One-time purchase)

## Cover Image Alt Text
Multi-tool AI coding config toolkit displayed across Cursor, Claude Code, Windsurf, and GitHub Copilot interfaces

---

## Product Description

### awesome-cursorrules gives you Cursor rules. We give you production configs for EVERY AI coding tool.

You're using Cursor. Your teammate uses Claude Code. Another dev on your team swears by Windsurf. Your company's repos have Copilot.

**Everyone's AI assistant writes different code.**

Different styles. Different patterns. Different quality. Because each tool needs its own config format, and nobody has time to maintain four separate rule files.

**Until now.**

---

### What You Get

**8 production-ready config sets** covering all 4 major AI coding tools:

Each stack includes:
- `.cursorrules` for Cursor
- `CLAUDE.md` for Claude Code
- `.windsurfrules` for Windsurf
- `.github/copilot-instructions.md` for GitHub Copilot

**Stacks covered:**

- **Next.js + TypeScript** — App Router, Server Components, Server Actions, Tailwind, Zod
- **React Native / Expo** — Expo Router, FlatList, native modules, platform code, Zustand
- **Python FastAPI** — Async patterns, Pydantic v2, SQLAlchemy 2.0, dependency injection
- **Node.js Express** — Middleware, validation, Prisma/Drizzle, JWT auth, error handling
- **Rust** — Ownership, lifetimes, thiserror/anyhow, tokio async, traits and generics
- **Go (Golang)** — Error handling, goroutines, interfaces, context, standard project layout
- **SvelteKit** — Svelte 5 runes, load functions, form actions, SSR, stores
- **Django + DRF** — Models, serializers, signals, Celery tasks, pytest, factory_boy

Each config set is **50-100 lines** of carefully crafted rules that cover:

- Project structure and file naming conventions
- Framework-specific patterns and best practices
- Code style preferences the AI must follow
- Common mistakes the AI must avoid
- Testing conventions and patterns

**Plus:**

- **Project-type starter templates** — Full-stack combos (Next.js + FastAPI, React Native + Express, etc.)
- **Auto-generator script** — Detects your stack and installs the right configs for all your AI tools
- **Setup validation** — Ensures configs are installed correctly
- **Customization guide** — How to add your team's conventions

---

### How to Use It

**Option 1: Manual (2 minutes)**

1. Download the zip
2. Find the config set for your stack (e.g., `nextjs-typescript/`)
3. Copy the config files for your AI tools to your project root
4. Start coding with consistent AI output across all tools

**Option 2: Auto-Generator (30 seconds)**

1. Run `node bin/generate.js` in your project
2. It detects your stack automatically
3. It asks which AI tools you use
4. It installs everything for you

**That's it.** No configuration. No plugins. No setup. Just better AI output, immediately, across every AI coding tool your team uses.

---

### Why This vs Free Alternatives

| Feature | awesome-cursorrules | cursor.directory | AI Dev Config Toolkit |
|---------|---------------------|------------------|----------------------|
| Cursor rules | Yes | Yes | Yes |
| CLAUDE.md templates | No | No | Yes |
| Windsurf configs | No | No | Yes |
| Copilot instructions | No | No | Yes |
| Project-type starters | No | No | Yes |
| Auto-generator | No | No | Yes |
| Production-tested | Sometimes | Sometimes | Always |
| Framework-current | Varies | Varies | Yes |
| Length/Quality | 10-20 lines | 10-30 lines | 50-100 lines |

**The key difference:** Free alternatives give you basic Cursor rules, often copied from docs or written by AI. We give you complete configuration coverage for all major AI coding tools, with deep, opinionated guidance tested in production.

---

### Works With Every AI Coding Tool

| Tool | File Format | Included |
|------|-------------|----------|
| **Cursor** | `.cursorrules` | Yes |
| **Claude Code** | `CLAUDE.md` | Yes |
| **Windsurf** | `.windsurfrules` | Yes |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Yes |
| **Cline** | `.clinerules` | Yes (same as Cursor) |

Same guidance, optimized formatting for each tool. One purchase, universal coverage.

---

### What Makes These Configs Different

**They're production-tested, not documentation summaries.**

We didn't copy-paste from framework docs or ask ChatGPT to write rules. Every rule exists because we've seen AI assistants make that specific mistake in real projects. These configs are the distilled knowledge of shipping production code with AI assistance across 8 different stacks.

**They're framework-current.**

Updated for Next.js 14+, Svelte 5, Pydantic v2, SQLAlchemy 2.0, Go 1.22+, Django 5.0+. No outdated patterns. No deprecated APIs.

**They're opinionated.**

Your AI needs clear direction, not "consider using X." These configs say "Use X. Never use Y. Here's why." That's what gets results.

**They're the right length.**

Too short and the AI ignores critical patterns. Too long and it overflows the context window. Each config is 50-100 lines — the sweet spot for maximum impact without bloat.

**They're multi-tool native.**

Not just Cursor rules copy-pasted into different file names. Each tool gets formatting optimized for how that tool processes instructions.

---

### The Auto-Generator

Included auto-generator (`bin/generate.js`) that:

1. **Detects your stack** — Analyzes `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`
2. **Asks which AI tools you use** — Cursor? Claude Code? Both? All four?
3. **Installs configs** — Puts each file in the right location with correct formatting
4. **Validates** — Confirms everything is set up correctly

Example output:
```
Detected stack: Next.js 14 + TypeScript
Which AI tools do you use?
[x] Cursor
[x] Claude Code
[ ] Windsurf
[ ] GitHub Copilot

Installing configs:
  ✓ .cursorrules
  ✓ CLAUDE.md

Done! Your AI tools are now configured for Next.js best practices.
```

---

### Fully Customizable

Every file is plain text. Add your team's conventions, remove rules you disagree with, merge configs for full-stack projects. A detailed customization guide is included showing:

- How to add project-specific rules
- How to modify existing rules for your team
- How to combine multiple stacks
- How to share configs across your team
- How to version control your customizations

---

### FAQ

**Q: I only use Cursor. Why do I need configs for other tools?**
A: Your teammates might use different tools. Your company might standardize on Copilot. You might switch tools next month. One purchase covers all scenarios. Plus, the configs help you understand what makes AI output consistent across tools.

**Q: Will these work with future versions of these tools?**
A: Yes. All these tools use plain text config files that have been stable since launch. If any tool changes its format, you get free updates.

**Q: Can I use these for commercial projects?**
A: Absolutely. Use them in any project — personal, client, or enterprise. The only restriction is you cannot resell the config collection itself.

**Q: What if my stack isn't listed?**
A: The included configs serve as excellent templates. Use the structure and patterns to create configs for any stack. The auto-generator also works with custom stacks.

**Q: How is this different from free .cursorrules files on GitHub?**
A: Three ways:
1. **Multi-tool support** — Free files are Cursor-only. We cover all major AI coding tools.
2. **Depth** — Most free rules are 10-20 lines of vague suggestions. Ours are 50-100 lines of specific, tested guidance.
3. **Maintained** — Free files go stale. We update for new framework versions and tool capabilities.

**Q: Do I need to know how to code to customize these?**
A: No. The config files are plain English instructions. If you can read a bullet list, you can customize these.

---

### The Math

**Without proper configs:**
- Your AI generates code → you spend 5-10 minutes fixing it
- 30-60 minutes wasted per day across your team
- Different output quality depending on which tool each person uses
- Inconsistent code style across your codebase

**With AI Dev Config Toolkit:**
- One-time $14 investment
- 2 minutes to install
- Consistent, high-quality AI output across all tools
- Same code patterns regardless of which AI tool your team uses

**These configs pay for themselves in the first hour.**

---

### What You Get (Summary)

- 8 production-tested config sets for popular stacks
- 4 config files per stack (Cursor, Claude Code, Windsurf, Copilot)
- Project-type starter templates for full-stack combos
- Auto-generator script with stack detection
- Customization guide
- Team sharing best practices
- Lifetime updates
- Commercial use license

**32 config files total + auto-generator + starters + guides**

**$14. One-time payment. No subscription.**

---

*Built for developers who want their AI to write code the right way, the first time — no matter which AI coding tool they use.*
