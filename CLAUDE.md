# CursorRules Pro

## Overview
Collection of 8 curated `.cursorrules` files for popular tech stacks. Drop-in AI coding rules for Cursor, Cline, Claude Code, and GitHub Copilot. Sold at $14.

## Tech Stack
- **Format:** Plain text `.cursorrules` files (no framework, no dependencies)
- **Distribution:** Git repo / digital download

## Key Commands
- No build or dev commands -- this is a content product
- To use: copy a `.cursorrules` file into your project root

## Project Structure
- `rules/` -- 8 stack-specific rule sets (each in its own subdirectory)
  - `rules/nextjs-typescript/.cursorrules` -- Next.js + TypeScript (App Router, Tailwind, Zod)
  - `rules/react-native/.cursorrules` -- React Native / Expo
  - `rules/python-fastapi/.cursorrules` -- Python FastAPI (Pydantic v2, SQLAlchemy 2.0)
  - `rules/node-express/.cursorrules` -- Node.js Express (Prisma/Drizzle, JWT)
  - `rules/rust/.cursorrules` -- Rust (tokio, thiserror/anyhow)
  - `rules/golang/.cursorrules` -- Go (goroutines, table-driven tests)
  - `rules/svelte-kit/.cursorrules` -- SvelteKit (Svelte 5 runes)
  - `rules/django/.cursorrules` -- Django (DRF, Celery, pytest-django)
- `starters/` -- 4 advanced project starter configs
  - `starters/nextjs-saas/` -- Complete Next.js SaaS setup (auth, Stripe, Prisma, .vscode, pre-commit)
  - `starters/python-api/` -- Python FastAPI/Flask setup (SQLAlchemy, Alembic, Makefile)
  - `starters/react-native/` -- React Native/Expo setup (navigation, state, native APIs)
  - `starters/monorepo/` -- Turborepo/Nx monorepo setup (workspaces, caching, versioning)
  - `starters/setup.sh` -- Bash setup script for installing starters
  - `starters/setup.ps1` -- PowerShell setup script for Windows
  - `starters/README.md` -- Documentation for starters
- `tools/` -- Automation scripts
  - `tools/generate-claude-md.sh` -- Auto-generates CLAUDE.md from project structure
  - `tools/migrate-cursorrules.sh` -- Converts between .cursorrules and CLAUDE.md formats
  - `tools/README.md` -- Documentation for tools
- `README.md` -- Usage guide, customization instructions, compatibility table
- `GUMROAD_LISTING.md` -- Sales copy
- `.gitignore` -- Ignores OS/editor files

## Key Files
- `rules/*/.cursorrules` -- The 8 stack-specific rule files (~50-100 lines each)
- `starters/*/` -- 4 advanced starter configs with CLAUDE.md, .vscode, hooks, Makefiles
- `starters/setup.sh` / `setup.ps1` -- One-command installer for starters
- `tools/generate-claude-md.sh` -- Auto-generates project context
- `tools/migrate-cursorrules.sh` -- Format converter
- `README.md` -- Full documentation with examples and compatibility info

## Stripe Integration
- Payment link: `buy.stripe.com/8x24gydPfeFY1AU5Bo08g05` ($14)
- No runtime Stripe integration (digital product, one-time purchase)

## Notes
- Rule files are dotfiles (hidden by default in file explorers)
- Each file is 50-100 lines of opinionated, production-tested guidance
- Compatible with: `.cursorrules`, `.clinerules`, `CLAUDE.md`, `.github/copilot-instructions.md`, `.windsurfrules`
- Users can combine multiple stack rules for full-stack projects
- Repo: github.com/Wittlesus/cursorrules-pro
