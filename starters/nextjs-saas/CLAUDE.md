# [Project Name] — Next.js SaaS

## Overview
[Brief description of what this SaaS product does]

## Tech Stack
- **Framework:** Next.js 14+ (App Router)
- **Language:** TypeScript (strict mode)
- **Styling:** Tailwind CSS + shadcn/ui
- **Database:** PostgreSQL + Prisma ORM
- **Auth:** NextAuth.js (Auth.js) v5
- **Payments:** Stripe (subscriptions + webhooks)
- **Email:** React Email + Resend
- **Deployment:** Vercel

## Key Commands
```bash
npm run dev           # Start development server (localhost:3000)
npm run build         # Build for production
npm run start         # Start production server
npm run lint          # Run ESLint
npm run type-check    # TypeScript type checking
npx prisma studio     # Open Prisma Studio (database GUI)
npx prisma migrate dev # Run database migrations
npx prisma generate   # Generate Prisma Client
```

## Project Structure
```
app/
  (auth)/             # Auth routes (login, signup, reset-password)
  (dashboard)/        # Protected dashboard routes
  api/                # API routes (webhooks, external integrations)
  _components/        # Shared components
components/           # UI components (shadcn/ui)
lib/
  auth.ts             # Auth helpers (getServerSession, etc.)
  db.ts               # Prisma Client singleton
  stripe.ts           # Stripe client + webhook handlers
  validations/        # Zod schemas
prisma/
  schema.prisma       # Database schema
  migrations/         # Database migrations
public/               # Static assets
```

## Key Files
- `app/api/webhooks/stripe/route.ts` — Stripe webhook handler (subscription events)
- `lib/auth.ts` — Auth configuration and helpers
- `lib/stripe.ts` — Stripe integration (checkout, subscriptions, webhooks)
- `prisma/schema.prisma` — Database schema (User, Subscription, Usage, etc.)
- `middleware.ts` — Edge middleware for auth protection
- `.env.local` — Environment variables (Stripe keys, database URL, NextAuth secret)

## Environment Variables
```bash
# Database
DATABASE_URL=postgresql://...

# Auth
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=... # Generate with: openssl rand -base64 32

# Stripe
STRIPE_PUBLIC_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
STRIPE_PRICE_ID_BASIC=price_...
STRIPE_PRICE_ID_PRO=price_...

# Email
RESEND_API_KEY=re_...
EMAIL_FROM=noreply@yourdomain.com
```

## Database Schema Notes
- `User` model: id, email, name, role (USER | ADMIN), stripeCustomerId
- `Subscription` model: id, userId, stripeSubscriptionId, status, plan, currentPeriodEnd
- `Usage` model: id, userId, month, apiCalls (for usage tracking)
- All models have createdAt/updatedAt timestamps

## Authentication Flow
1. User signs up via `/signup` → creates User record
2. NextAuth creates session in database
3. Middleware checks session on protected routes
4. Server Components use `getServerSession()` for user data

## Payment Flow
1. User clicks "Upgrade to Pro" → redirect to Stripe Checkout
2. Stripe Checkout completes → webhook to `/api/webhooks/stripe`
3. Webhook creates/updates Subscription record
4. User redirected to `/dashboard` with pro access

## Access Control
- Check `user.role` for admin-only features
- Check `user.subscription.status === 'active'` for pro features
- Check `user.usage.apiCalls < LIMIT` for rate limiting
- All checks happen server-side (Server Components, Server Actions, API routes)

## Architectural Decisions
- Server Components by default for better performance and SEO
- Server Actions for mutations to avoid unnecessary API routes
- Database sessions (not JWT-only) for easier revocation
- Stripe webhooks for reliable subscription state (not polling)
- React Email for type-safe, version-controlled email templates

## Common Tasks
### Add a new protected route
1. Create route in `app/(dashboard)/new-route/page.tsx`
2. Middleware automatically protects all `(dashboard)` routes
3. Use `getServerSession()` to access user data

### Add a new Stripe plan
1. Create price in Stripe Dashboard
2. Add STRIPE_PRICE_ID_* to .env.local
3. Add plan to pricing page and checkout flow

### Add a new webhook event
1. Add handler in `lib/stripe.ts` → handleWebhook()
2. Update Stripe webhook settings in Dashboard
3. Test with Stripe CLI: `stripe trigger <event>`

## Deployment
- Deploy to Vercel (automatic on git push)
- Set environment variables in Vercel dashboard
- Run migrations: `npx prisma migrate deploy` (set in Vercel build command)
- Update Stripe webhook URL to production domain

## Notes
- Prisma Client is instantiated as singleton to avoid connection limits in serverless
- Stripe webhooks are idempotent (check if event already processed before updating database)
- All Server Actions return `{ success, data?, error? }` for consistent error handling
- Use `revalidatePath()` after mutations to update cached data
