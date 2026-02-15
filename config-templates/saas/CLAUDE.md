# Next.js + TypeScript SaaS Project

## Overview
This is a modern SaaS application built with Next.js 14+ App Router, TypeScript, and Tailwind CSS. The project follows Server Components first approach with strict TypeScript and production-ready patterns.

## Tech Stack
- **Framework**: Next.js 14+ (App Router)
- **Language**: TypeScript (strict mode)
- **Styling**: Tailwind CSS
- **Validation**: Zod
- **Testing**: Vitest, React Testing Library
- **Database**: (specify: Prisma/Drizzle with PostgreSQL/MySQL)
- **Auth**: (specify: NextAuth, Clerk, Supabase Auth)
- **Payments**: (specify: Stripe, Paddle)

## Project Structure
```
app/
  ├── (auth)/          # Auth route group
  ├── (dashboard)/     # Protected dashboard routes
  ├── (marketing)/     # Public marketing pages
  └── api/            # API routes (use sparingly)
components/
  ├── ui/             # Shadcn/ui components
  └── shared/         # Shared components
lib/
  ├── actions/        # Server actions
  ├── db/            # Database client and schemas
  ├── utils/         # Utility functions
  └── validations/   # Zod schemas
```

## Key Commands
```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run test         # Run tests
npm run lint         # Lint code
npm run type-check   # TypeScript check
```

## Development Rules

### Server Components First
- **Default to Server Components**. Only add `"use client"` when absolutely necessary:
  - User interactions (onClick, onChange, form submissions without Server Actions)
  - React hooks (useState, useEffect, useContext)
  - Browser APIs (localStorage, window, navigator)
  - Third-party libraries that require client-side execution
- Server Components can be async and fetch data directly
- Use Server Actions for mutations instead of API routes

### TypeScript Standards
- **strict mode enabled** — No `any` types allowed
- Define explicit return types on all exported functions
- Use Zod for runtime validation, TypeScript for compile-time safety
- Prefer `interface` for object shapes, `type` for unions/intersections

### Data Fetching Pattern
```typescript
// ✅ Server Component - fetch directly
async function UserProfile({ userId }: Props) {
  const user = await db.user.findUnique({ where: { id: userId } });
  return <div>{user.name}</div>;
}

// ❌ Don't do this - no useEffect for data fetching
'use client';
function UserProfile({ userId }: Props) {
  const [user, setUser] = useState();
  useEffect(() => { fetch(...) }, []);
}
```

### Server Actions Pattern
```typescript
// app/actions/users.ts
'use server';

export async function updateUser(formData: FormData) {
  const parsed = userSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    return { error: parsed.error.flatten() };
  }

  await db.user.update({ ... });
  revalidatePath('/dashboard');
  return { success: true };
}
```

### Styling Conventions
- Tailwind utility-first approach
- Mobile-first responsive design
- Use `cn()` for conditional classes:
  ```typescript
  import { cn } from '@/lib/utils';

  <div className={cn(
    "base-classes",
    isActive && "active-classes",
    variant === 'primary' && "primary-classes"
  )} />
  ```

### Error Handling
- Every route segment with data fetching needs `loading.tsx` and `error.tsx`
- Server Actions return typed error objects (never throw for expected errors)
- Use `not-found.tsx` for 404 handling
- Log all errors server-side with context (userId, route, timestamp)

### Performance Best Practices
- Use `next/image` with explicit dimensions
- Use `next/font` for font optimization
- Implement `generateStaticParams()` for dynamic routes
- Use `Suspense` for streaming large data
- Lazy load heavy client components with `next/dynamic`

### Testing Strategy
- Server Components: Integration tests
- Client Components: Unit tests with RTL
- Mock all external dependencies (DB, APIs, auth)
- Test file co-location: `component.tsx` → `component.test.tsx`

## Environment Variables
Create `.env.local` with:
```bash
DATABASE_URL=
NEXTAUTH_SECRET=
NEXTAUTH_URL=
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
```

## Database Migrations
```bash
npm run db:generate  # Generate migration
npm run db:migrate   # Apply migration
npm run db:studio    # Open DB GUI
```

## Common Patterns

### Protected Routes
Use middleware.ts or layout-level auth checks:
```typescript
// app/(dashboard)/layout.tsx
import { auth } from '@/lib/auth';
import { redirect } from 'next/navigation';

export default async function DashboardLayout({ children }) {
  const session = await auth();
  if (!session) redirect('/login');
  return children;
}
```

### Form Handling with Server Actions
```typescript
// components/user-form.tsx
'use client';
import { useFormState } from 'react-dom';
import { updateUser } from '@/lib/actions/users';

export function UserForm() {
  const [state, action] = useFormState(updateUser, null);

  return (
    <form action={action}>
      <input name="name" />
      {state?.error?.name && <p>{state.error.name}</p>}
      <button type="submit">Save</button>
    </form>
  );
}
```

## Key Reminders for AI Assistants
1. **Never use Pages Router patterns** — this is App Router only
2. **Server Components by default** — add `"use client"` only when needed
3. **No useEffect for data** — fetch directly in Server Components
4. **Validate everything** — use Zod schemas for all user input
5. **Type everything** — no `any`, explicit return types on exports
6. **Path aliases only** — use `@/` instead of relative imports
7. **Server Actions > API routes** — prefer Server Actions for mutations
8. **Mobile-first Tailwind** — responsive design from small to large screens

## Build & Deploy
```bash
npm run build        # Creates .next/ production build
npm run start        # Runs production server
# Or deploy to Vercel/Netlify/etc for automatic builds
```

## Troubleshooting
- **Hydration errors**: Check for server/client mismatch (dates, random values, localStorage)
- **Type errors**: Run `npm run type-check` to see full TypeScript diagnostics
- **Build fails**: Check for dynamic requires, missing env vars, or Pages Router imports
- **Slow loads**: Add `loading.tsx`, implement Suspense, check for N+1 queries
