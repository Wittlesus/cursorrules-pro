# GitHub Copilot Instructions — Next.js + TypeScript SaaS

## Project Context
This is a Next.js 14+ application using the App Router with TypeScript (strict mode), Tailwind CSS, and Server Components first architecture.

## Code Generation Rules

### TypeScript Standards
- Always use strict TypeScript — no `any` types
- Define explicit return types on exported functions
- Prefer `interface` for object shapes, `type` for unions/intersections
- Use Zod for runtime validation at API boundaries

### Next.js App Router Conventions
- **Server Components by default** — only add `"use client"` when necessary:
  - User interactions (onClick, onChange, useState, useEffect)
  - Browser APIs (localStorage, window)
  - Client-only libraries
- Use Server Actions (`"use server"`) for form submissions and mutations
- Never suggest Pages Router patterns (getServerSideProps, getStaticProps, pages/ directory)
- File-based routing in `app/` directory only

### Component Structure
```typescript
// Server Component (default)
async function ProductList() {
  const products = await db.product.findMany();
  return <div>...</div>;
}

// Client Component (only when needed)
'use client';
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

### Data Fetching
- Fetch data directly in Server Components with `async/await`
- Use `fetch()` with Next.js caching options: `{ next: { revalidate: 3600 } }`
- Never use `useEffect` for initial data loading
- Implement `loading.tsx` and `error.tsx` for route segments

### Server Actions Pattern
```typescript
'use server';

export async function updateProfile(formData: FormData) {
  const parsed = profileSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    return { error: parsed.error.flatten() };
  }

  await db.user.update({ ... });
  revalidatePath('/profile');
  return { success: true };
}
```

### Styling with Tailwind
- Use Tailwind utility classes, not inline styles or CSS modules
- Mobile-first responsive design: `base → sm: → md: → lg: → xl:`
- Use `cn()` utility for conditional classes:
  ```typescript
  import { cn } from '@/lib/utils';
  className={cn("base", isActive && "active", error && "error")}
  ```

### Import Conventions
- Use path alias `@/` for all imports from project root
- Never use relative imports that traverse up directories (`../../../`)
- Group imports: React → Next.js → third-party → local

### Error Handling
- Validate all user input with Zod schemas
- Return typed error objects from Server Actions (never throw for expected errors)
- Use error boundaries (`error.tsx`) for unexpected errors
- Implement `not-found.tsx` for 404 handling

### File Naming
- Routes: kebab-case (`user-profile/page.tsx`)
- Components: PascalCase (`UserProfile.tsx`)
- Utils/helpers: camelCase (`formatDate.ts`)
- Server Actions: grouped in `lib/actions/` by feature

### Performance Optimization
- Use `next/image` with explicit width/height or fill mode
- Use `next/font` for web fonts (never CDN imports)
- Implement `generateStaticParams()` for dynamic routes that can be pre-rendered
- Lazy load heavy client components with `next/dynamic`
- Use `Suspense` for streaming responses

### Testing Approach
- Server Components: integration tests
- Client Components: unit tests with React Testing Library
- Place tests adjacent to source files
- Mock external dependencies (database, APIs)

## Common Mistakes to Avoid
- ❌ Don't use `useEffect` for data fetching in Server Components
- ❌ Don't add `"use client"` to every file
- ❌ Don't create API routes for simple mutations (use Server Actions)
- ❌ Don't use Pages Router syntax
- ❌ Don't ignore TypeScript errors
- ❌ Don't skip input validation

## When Generating Code
1. Check if component needs client-side interactivity before adding `"use client"`
2. Use Server Actions for form handling and mutations
3. Validate all inputs with Zod schemas
4. Use proper TypeScript types (no `any`)
5. Follow mobile-first responsive design
6. Include error handling and loading states
7. Use path aliases (`@/`) for imports
8. Add comments for complex business logic only
