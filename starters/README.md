# Advanced Starters — AI Dev Config Toolkit

Complete, production-ready AI configurations for common project types.

## What Makes These Advanced?

Unlike basic `.cursorrules` files, these starters include:
- **Deep, opinionated configs** (50-130 lines) covering architecture, not just syntax
- **CLAUDE.md project context** — structure, key files, commands, deployment
- **Pre-commit hooks** for AI-assisted code review
- **IDE configs** (VS Code settings, recommended extensions)
- **Makefiles** with documented commands (for Python)
- **One-command setup** (Bash + PowerShell scripts)

No free collection offers this level of depth.

## Available Starters

### 1. Next.js SaaS (`nextjs-saas`)

For production SaaS applications with authentication, payments, and database.

**Includes:**
- `.cursorrules` — SaaS-specific patterns (NextAuth, Stripe, Prisma, RBAC)
- `CLAUDE.md` — Project structure, auth flow, payment flow, deployment
- `.vscode/settings.json` — Tailwind IntelliSense, ESLint, Prettier, recommended extensions
- `pre-commit` hook — Type checking, linting, secret detection, Prisma validation

**Key topics:**
- NextAuth.js v5 database sessions
- Stripe integration (checkout, webhooks, subscriptions)
- Server Actions vs API routes
- Prisma ORM patterns
- Role-based access control
- Security best practices

**Use when:**
- Building a SaaS product
- Need authentication + payments
- Want production-ready patterns

---

### 2. Python API (`python-api`)

For production REST APIs with FastAPI or Flask.

**Includes:**
- `.cursorrules` — FastAPI/Flask async patterns, SQLAlchemy 2.0, Pydantic v2
- `CLAUDE.md` — API structure, auth flow, endpoint examples, deployment
- `Makefile` — Documented commands (dev, test, lint, migrate)

**Key topics:**
- FastAPI async patterns
- SQLAlchemy 2.0 async ORM
- Pydantic v2 validation
- JWT authentication
- Alembic migrations
- Dependency injection
- Testing with pytest

**Use when:**
- Building a REST API
- Using FastAPI or Flask
- Need async database operations

---

### 3. React Native (`react-native`)

For production mobile apps with Expo.

**Includes:**
- `.cursorrules` — Mobile-specific patterns, Expo Router, platform differences
- `CLAUDE.md` — Navigation structure, state management, native APIs, deployment

**Key topics:**
- Expo Router file-based routing
- FlatList optimization
- Platform-specific code (iOS/Android)
- State management (Zustand + TanStack Query)
- Push notifications
- SecureStore for sensitive data
- EAS Build and Updates

**Use when:**
- Building a mobile app
- Using React Native + Expo
- Need cross-platform (iOS + Android)

---

### 4. Monorepo (`monorepo`)

For Turborepo or Nx monorepos with shared packages and multiple apps.

**Includes:**
- `.cursorrules` — Monorepo patterns, workspace imports, task orchestration
- `CLAUDE.md` — Workspace structure, dependency graph, task pipeline, versioning

**Key topics:**
- Turborepo/Nx task pipelines
- pnpm workspace configuration
- Cross-package imports
- Shared packages (UI, utils, types, config)
- Incremental builds and caching
- Versioning with Changesets
- CI/CD optimization

**Use when:**
- Managing multiple apps/packages in one repo
- Sharing code between frontend/backend
- Need efficient builds with caching

---

## Setup Instructions

### One-Command Install

**Bash (Linux/macOS/Git Bash on Windows):**
```bash
./setup.sh <starter-type> <target-directory>
```

**PowerShell (Windows):**
```powershell
.\setup.ps1 <starter-type> <target-directory>
```

**Examples:**
```bash
# Next.js SaaS
./setup.sh nextjs-saas ~/my-saas-project

# Python API
./setup.sh python-api /var/www/api

# React Native
./setup.sh react-native ~/mobile-app

# Monorepo
./setup.sh monorepo ~/my-monorepo
```

### What Gets Installed

The setup script copies:
1. `.cursorrules` → Project root
2. `CLAUDE.md` → Project root
3. `.vscode/settings.json` → `.vscode/` directory (if applicable)
4. `pre-commit` hook → `.git/hooks/pre-commit` (if git repo exists)
5. `Makefile` → Project root (for Python API)

### Manual Installation

If you prefer manual setup:

1. Copy the `.cursorrules` file to your project root
2. Copy the `CLAUDE.md` file to your project root
3. Customize both files with your project-specific details
4. (Optional) Copy `.vscode/settings.json` if you use VS Code
5. (Optional) Install pre-commit hook: `cp pre-commit .git/hooks/ && chmod +x .git/hooks/pre-commit`

---

## Customization

All files are templates — customize them for your project:

### Update CLAUDE.md
1. Replace `[Project Name]` with your project name
2. Fill in `[Overview]` with your project description
3. Update environment variables section
4. Add project-specific notes and conventions

### Customize .cursorrules
1. Add project-specific rules at the top
2. Remove rules that don't apply
3. Add code examples for complex patterns

### Extend Pre-Commit Hook
Add checks specific to your project:
```bash
# Check for TODO comments before committing
if grep -rq "TODO" app/; then
  echo "⚠️ Warning: TODO comments found"
fi
```

---

## Compatibility

All starters work with:
- **Cursor** — Uses `.cursorrules`
- **Cline** — Rename to `.clinerules`
- **Claude Code** — Uses `CLAUDE.md`
- **GitHub Copilot** — Copy content to `.github/copilot-instructions.md`
- **Windsurf** — Rename to `.windsurfrules`

---

## Examples

### Combining Starters

For full-stack projects, use multiple starters:

```bash
# Set up monorepo structure
./setup.sh monorepo ~/my-fullstack-app

# Then add Next.js SaaS config to apps/web
./setup.sh nextjs-saas ~/my-fullstack-app/apps/web

# And Python API config to apps/api
./setup.sh python-api ~/my-fullstack-app/apps/api
```

Each package/app gets its own `.cursorrules` and `CLAUDE.md` tailored to its stack.

---

## Why These Are Better Than Free Alternatives

| Feature | Free .cursorrules | AI Dev Config Toolkit Starters |
|---------|-------------------|--------------------------------|
| Lines of guidance | 10-30 | 50-130 |
| Covers architecture | No | Yes |
| Project context | No | Yes (CLAUDE.md) |
| Setup automation | No | Yes (setup scripts) |
| IDE integration | No | Yes (.vscode configs) |
| Pre-commit hooks | No | Yes |
| Production patterns | Sometimes | Always |
| SaaS-specific rules | No | Yes (auth, payments, RBAC) |
| Mobile-specific rules | Basic | Deep (permissions, platforms) |
| Monorepo patterns | No | Yes (Turborepo/Nx) |

---

## Need Help?

1. Check the `CLAUDE.md` in each starter for detailed setup instructions
2. Run setup script with `-h` flag for help
3. Read main README for tool compatibility

---

**No free collection has configs this comprehensive.**
