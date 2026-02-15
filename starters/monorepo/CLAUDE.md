# [Project Name] — Monorepo

## Overview
[Brief description of this monorepo and what apps/packages it contains]

## Tech Stack
- **Monorepo:** Turborepo (or Nx)
- **Package Manager:** pnpm
- **Language:** TypeScript
- **Apps:** Next.js (web), React Native (mobile), FastAPI (api)
- **Shared:** UI components, utilities, types, database schema

## Key Commands
```bash
# Development
pnpm dev                          # Start all apps in dev mode
pnpm dev --filter=web             # Start only web app
pnpm dev --filter=web...          # Start web and its dependencies

# Building
pnpm build                        # Build all packages and apps
pnpm build --filter=web           # Build only web app
pnpm build --force                # Rebuild ignoring cache

# Testing
pnpm test                         # Run all tests
pnpm test --filter=api            # Run tests for api only
pnpm test -- --watch              # Run tests in watch mode

# Linting
pnpm lint                         # Lint all packages
pnpm lint --fix                   # Fix lint errors

# Dependencies
pnpm add <package> --filter=web   # Add to specific package
pnpm add -Dw <package>            # Add dev dependency at root
pnpm update -r                    # Update all packages

# Turborepo
turbo run build --dry             # Show execution plan
turbo run build --graph           # Visualize task dependency graph
turbo run build --force           # Skip cache

# Versioning (with Changesets)
pnpm changeset                    # Create a changeset
pnpm version-packages             # Update versions from changesets
pnpm release                      # Publish packages to npm
```

## Monorepo Structure
```
apps/
  web/                  # Next.js web app (customer-facing)
    package.json
    src/
  admin/                # Next.js admin dashboard
  mobile/               # React Native mobile app
  api/                  # Python FastAPI backend
packages/
  ui/                   # Shared React components (buttons, forms, etc.)
    src/
    package.json
  utils/                # Shared utilities (formatters, validators, etc.)
  types/                # Shared TypeScript types (API contracts)
  config/               # Shared configs (ESLint, TypeScript, Tailwind)
    eslint/
    typescript/
    tailwind/
  database/             # Prisma schema + client
    prisma/
      schema.prisma
turbo.json              # Turborepo pipeline configuration
pnpm-workspace.yaml     # pnpm workspace configuration
package.json            # Root package.json with workspace scripts
```

## Package Dependency Graph
```
web → ui → config/eslint
      ↓     config/typescript
      utils
      types
      database

mobile → ui (React Native compatible components only)
         utils
         types

api → types
      database
```

## Key Files
- `turbo.json` — Turborepo task pipeline and caching config
- `pnpm-workspace.yaml` — Defines workspace packages (`apps/*`, `packages/*`)
- `packages/database/prisma/schema.prisma` — Shared database schema
- `packages/types/src/api.ts` — API contract types (shared between web and api)
- `packages/config/eslint/index.js` — Shared ESLint config

## Turborepo Pipeline (turbo.json)
```json
{
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "test": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    },
    "lint": {
      "outputs": []
    }
  }
}
```

- `dependsOn: ["^build"]` — Build dependencies before building this package
- `outputs` — Files to cache
- `cache: false` — Don't cache dev task (always run)
- `persistent: true` — Keep running (for dev servers)

## Workspace Configuration (pnpm-workspace.yaml)
```yaml
packages:
  - 'apps/*'
  - 'packages/*'
```

This tells pnpm to treat all directories in `apps/` and `packages/` as workspace packages.

## Cross-Package Imports
All packages use workspace aliases defined in each package's `package.json`:

```json
{
  "name": "@repo/web",
  "dependencies": {
    "@repo/ui": "workspace:*",
    "@repo/utils": "workspace:*",
    "@repo/types": "workspace:*"
  }
}
```

Import in code:
```typescript
import { Button } from '@repo/ui';
import { formatDate } from '@repo/utils';
import type { User } from '@repo/types';
```

## TypeScript Configuration
- Root `tsconfig.json` with shared compiler options
- Each package has own `tsconfig.json` extending root:
  ```json
  {
    "extends": "../../tsconfig.json",
    "compilerOptions": {
      "outDir": "dist"
    },
    "include": ["src"]
  }
  ```
- Use project references for incremental builds

## Shared Packages

### @repo/ui
Shared React components used by web, admin, and mobile.
- Built with tsup (fast TypeScript bundler)
- Exports from `src/index.ts`
- Storybook for component documentation
- Platform-aware: `.web.tsx` for web-only, `.native.tsx` for mobile

### @repo/utils
Shared utility functions (formatters, validators, etc.).
- Pure JavaScript/TypeScript (no React)
- Tree-shakeable exports
- Fully tested

### @repo/types
Shared TypeScript types and interfaces.
- API contract types (request/response schemas)
- Domain models (User, Post, etc.)
- No runtime code, types only

### @repo/config
Shared configuration for ESLint, TypeScript, Tailwind.
- Apps extend these configs: `"extends": "@repo/config/eslint"`
- Centralized config means one place to update rules

### @repo/database
Prisma schema and client.
- Single source of truth for database schema
- Exported Prisma Client used by all apps that need DB access
- Migrations run from this package

## Development Workflow

### Starting Development
```bash
pnpm dev                # Start all apps (web, mobile, api)
pnpm dev --filter=web   # Start only web app
```

Turborepo runs all dev tasks in parallel. Each app watches for changes.

### Building
```bash
pnpm build              # Build all packages in dependency order
```

Turborepo:
1. Builds `@repo/config`, `@repo/types`, `@repo/utils` (no dependencies)
2. Builds `@repo/ui` (depends on config/types/utils)
3. Builds `@repo/database` (depends on types)
4. Builds apps (depend on all packages)

### Adding a Dependency
```bash
# Add to specific package
pnpm add react-hook-form --filter=web

# Add dev dependency to root (shared across all packages)
pnpm add -Dw prettier

# Add dependency to all packages
pnpm add -r lodash
```

### Creating a New Package
1. Create directory: `packages/new-package`
2. Add `package.json` with `"name": "@repo/new-package"`
3. Add `tsconfig.json` extending root
4. Add to `turbo.json` pipeline if needed
5. Use in apps: `pnpm add @repo/new-package --filter=web`

### Making Changes
1. Edit code in any package or app
2. Run `pnpm build` to ensure builds work
3. Run `pnpm lint` and `pnpm test`
4. Turborepo only rebuilds affected packages (caching FTW)

## Versioning & Publishing

Using Changesets for version management:

1. Make changes to packages
2. Create changeset: `pnpm changeset`
3. Choose packages to version (patch/minor/major)
4. Commit changeset file
5. On merge to main, CI runs `pnpm version-packages`
6. Publish: `pnpm release`

## CI/CD

Example GitHub Actions workflow:
```yaml
- uses: actions/setup-node@v3
  with:
    node-version: 18
- uses: pnpm/action-setup@v2
  with:
    version: 8
- run: pnpm install --frozen-lockfile
- run: pnpm build
- run: pnpm lint
- run: pnpm test
- run: pnpm deploy --filter=web  # Deploy apps
```

Use Turborepo Remote Caching for faster CI:
```yaml
env:
  TURBO_TOKEN: ${{ secrets.TURBO_TOKEN }}
  TURBO_TEAM: ${{ secrets.TURBO_TEAM }}
```

## Common Tasks

### Add a new app
1. Create `apps/new-app` directory
2. Add `package.json` with `"name": "@repo/new-app"`
3. Add dependencies: `pnpm add @repo/ui @repo/utils --filter=new-app`
4. Add scripts to root `package.json` if needed

### Add a shared component
1. Create component in `packages/ui/src/NewComponent.tsx`
2. Export from `packages/ui/src/index.ts`
3. Build UI package: `pnpm build --filter=ui`
4. Import in app: `import { NewComponent } from '@repo/ui';`

### Update shared config
1. Edit `packages/config/eslint/index.js`
2. All apps automatically use new config (they extend it)
3. Run `pnpm lint` to verify

### Run task for subset of packages
```bash
pnpm build --filter=web...        # Build web and its dependencies
pnpm test --filter=...api         # Test api and its dependents
pnpm lint --filter=./apps/*       # Lint all apps only
```

## Troubleshooting

### "Module not found" error
- Make sure package is built: `pnpm build --filter=<package>`
- Check package.json dependencies include workspace package
- Verify import path matches package name

### "Circular dependency" error
- Check package.json dependencies for circular refs
- Refactor to break circular dependency (extract shared code)

### Cache issues
- Clear cache: `turbo run build --force`
- Delete node_modules and reinstall: `pnpm clean && pnpm install`

### Slow builds
- Check turborepo cache is enabled (not using `--force`)
- Use remote caching for CI
- Check for duplicate dependencies: `pnpm dedupe`

## Notes
- pnpm stores packages once, links to node_modules (saves disk space)
- Turborepo caches task outputs (build, test) based on inputs
- Only changed packages are rebuilt (incremental builds)
- Use `--filter` to work on specific packages for faster iteration
- Remote caching shares cache across team and CI
