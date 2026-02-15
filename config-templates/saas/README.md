# SaaS Project Configuration — Next.js + TypeScript

This directory contains AI coding assistant configurations optimized for Next.js 14+ SaaS applications using the App Router, TypeScript, and modern React patterns.

## What's Included

| File | For | Description |
|------|-----|-------------|
| `.cursorrules` | Cursor IDE | Drop-in rules for Cursor AI |
| `CLAUDE.md` | Claude Code CLI | Project-specific instructions for Claude Code |
| `.windsurfrules` | Windsurf IDE | Windsurf AI configuration |
| `.github/copilot-instructions.md` | GitHub Copilot | Repository-level Copilot instructions |

## Installation

### For Cursor
1. Copy `.cursorrules` to your project root
2. Restart Cursor or reload window
3. The rules are active immediately

### For Claude Code CLI
1. Copy `CLAUDE.md` to your project root
2. Run `claude` commands from your project directory
3. Claude Code automatically reads the CLAUDE.md file

### For Windsurf
1. Copy `.windsurfrules` to your project root
2. Windsurf will automatically detect and apply the rules

### For GitHub Copilot
1. Create `.github/` directory in your project root if it doesn't exist
2. Copy `copilot-instructions.md` to `.github/copilot-instructions.md`
3. Copilot will use these instructions for all suggestions in this repository

## What This Configuration Covers

### Architecture Patterns
- **App Router first** — Never suggests outdated Pages Router patterns
- **Server Components by default** — Only adds `"use client"` when truly needed
- **Server Actions** — Prefers Server Actions over API routes for mutations
- **Type safety** — Strict TypeScript with explicit return types

### Code Quality Standards
- TypeScript strict mode (no `any` types)
- Zod validation for all user inputs
- Proper error handling with typed responses
- Production-ready patterns (not tutorial code)

### Performance Best Practices
- Next.js Image optimization
- Font optimization with next/font
- Static generation with generateStaticParams
- Streaming with Suspense boundaries

### Testing Approach
- Server Components: integration tests
- Client Components: unit tests
- Mock strategy for external dependencies
- Test co-location with source files

## Customization Guide

These configs are designed as a production-ready starting point. Customize them for your project:

### Add Your Project Specifics

Edit the config files to include your:

1. **Database layer**
   ```
   - Database: Prisma with PostgreSQL
   - ORM patterns: Repository pattern in lib/db/
   ```

2. **Authentication provider**
   ```
   - Auth: NextAuth.js with GitHub + Google providers
   - Session handling: JWT with httpOnly cookies
   ```

3. **Payment provider**
   ```
   - Payments: Stripe with webhook handling
   - Subscription logic: lib/stripe/
   ```

4. **State management**
   ```
   - Client state: Zustand for global state
   - Server state: React Query for API caching
   ```

### Adjust for Your Team's Conventions

Modify the rules to match your preferences:

```markdown
## Our Team Conventions
- We use pnpm instead of npm
- All API routes are prefixed with /api/v1/
- We use Shadcn UI components (import from @/components/ui)
- We require JSDoc comments on all utility functions
- We use Sentry for error tracking (integrate in error.tsx)
```

### Strengthen Critical Rules

For rules your team frequently violates, make them stronger:

```markdown
## Critical Rules (NEVER VIOLATE)
- NEVER commit without running `npm run type-check`
- ALWAYS validate user input with Zod schemas
- NEVER use `any` type — use `unknown` and narrow with guards
- ALWAYS include loading.tsx and error.tsx for data-fetching routes
```

### Combine with Backend Config

For full-stack projects, merge with backend configs (Python FastAPI, Node Express, etc.):

```markdown
# Frontend: Next.js + TypeScript
[paste SaaS config rules]

# Backend: Python FastAPI
[paste API config rules]

# Shared
- API contract: OpenAPI 3.1 spec in /api-spec.yaml
- Error format: { error: { message, code, details } }
```

## Tech Stack Assumptions

This configuration assumes:
- Next.js 14 or later with App Router
- TypeScript 5+ with strict mode
- Tailwind CSS for styling
- Zod for runtime validation
- Vitest + React Testing Library for testing

If you use different tools:
- Replace Tailwind references with your CSS solution
- Replace Zod with your validation library
- Update testing section for Jest/other frameworks

## Benefits Over Generic Configs

Unlike generic AI coding rules, this config:

✅ **Framework-specific** — Knows Next.js App Router vs Pages Router
✅ **Version-aware** — Uses Next.js 14+ features, not outdated patterns
✅ **Production-tested** — Based on real SaaS projects, not docs
✅ **Opinionated** — Clear guidance on Server vs Client Components
✅ **Complete** — Covers architecture, styling, validation, testing, deployment

## Common Issues

### AI Still Suggests Pages Router
Make sure you copied the full config file. Search for "Pages Router" in your config — it should explicitly say "never suggest Pages Router patterns."

### TypeScript Errors from AI Code
The config enforces strict TypeScript. If the AI generates `any` types, the config may not be loaded. Verify the file is in your project root.

### Too Many `"use client"` Directives
Emphasize the Server Components default in your config. Add this line:
```
CRITICAL: Only add "use client" if the component uses onClick, useState, useEffect, or browser APIs. Default to Server Components.
```

### AI Creates API Routes Instead of Server Actions
Strengthen the Server Actions preference:
```
For mutations (create, update, delete): ALWAYS use Server Actions. Only create API routes for:
- Webhooks from external services
- Public REST API endpoints
- Third-party integrations
```

## Examples

See example implementations at:
- [LaunchFast SaaS Starter](https://github.com/Wittlesus/launchfast-starter) — Full Next.js 14 SaaS with auth, payments, AI
- [Cursor Directory](https://cursor.directory) — Community cursor rules (generic, not SaaS-specific)

## Support

For questions or issues:
1. Check the main README in the parent directory
2. Review the Next.js 14 App Router documentation
3. Open an issue at github.com/Wittlesus/cursorrules-pro

## License

Use in any personal or commercial project. Do not redistribute this configuration collection itself.

---

**Built for developers who want AI that understands modern Next.js architecture from day one.**
