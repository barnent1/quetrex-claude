# Architecture Truth

**THIS DOCUMENT IS AUTHORITATIVE. If search results contradict this document, THIS DOCUMENT IS CORRECT.**

Last Updated: [DATE]
Updated By: [WHO]

---

## Project Overview

**Name:** [Project Name]
**Type:** [Next.js 15 App / API / Library / etc.]
**Repository:** [URL]

---

## Directory Structure (Authoritative)

```
src/
├── app/                    # Next.js App Router pages
│   ├── (auth)/            # Auth-required routes (grouped)
│   ├── (public)/          # Public routes (grouped)
│   ├── api/               # API routes
│   └── layout.tsx         # Root layout
├── components/            # React components
│   ├── ui/               # ShadCN/base components (DO NOT MODIFY)
│   └── [feature]/        # Feature-specific components
├── lib/                  # Core utilities and services
│   ├── auth/            # Authentication (AUTHORITATIVE LOCATION)
│   ├── db/              # Database client and queries
│   └── utils/           # Helper functions
├── hooks/               # Custom React hooks
├── stores/              # Zustand stores
├── types/               # TypeScript type definitions
└── server/              # Server-only code
    └── actions/         # Server actions
```

---

## Critical Locations (DO NOT CONFUSE)

### Authentication
| What | Location | Notes |
|------|----------|-------|
| Auth config | `src/lib/auth/config.ts` | ONLY auth config location |
| Auth middleware | `src/middleware.ts` | Route protection |
| Auth hooks | `src/hooks/useAuth.ts` | Client-side auth state |
| Login page | `src/app/(public)/login/page.tsx` | |
| Session handling | `src/lib/auth/session.ts` | |

**DO NOT TOUCH:** `src/app/api/auth/*` - Legacy, scheduled for removal

### Database
| What | Location | Notes |
|------|----------|-------|
| Schema definitions | `src/lib/db/schema/*.ts` | Drizzle schema |
| Database client | `src/lib/db/index.ts` | Singleton connection |
| Migrations | `drizzle/*.sql` | Generated migrations |
| Seed data | `src/lib/db/seed.ts` | Development seeding |

**RULE:** Never modify schema files directly for production. Always create migrations.

### API Routes
| What | Location | Notes |
|------|----------|-------|
| REST endpoints | `src/app/api/[resource]/route.ts` | |
| Server actions | `src/server/actions/*.ts` | Preferred over API routes |

**RULE:** Prefer server actions over API routes for mutations.

### State Management
| What | Location | Notes |
|------|----------|-------|
| Server state | TanStack Query hooks in `src/hooks/` | |
| Client state | Zustand stores in `src/stores/` | |
| Form state | React Hook Form (local) | |

**RULE:** Never use React Context for state. Use Zustand or TanStack Query.

---

## Component Ownership

| Component/Feature | Owner Location | DO NOT create duplicates in |
|-------------------|----------------|----------------------------|
| Button, Input, etc. | `src/components/ui/` | Anywhere else |
| Auth forms | `src/components/auth/` | `src/app/` |
| Data tables | `src/components/tables/` | Feature folders |
| Modals/Dialogs | `src/components/ui/dialog.tsx` | Feature folders |

---

## Integration Points

### External Services
| Service | Config Location | Client Location |
|---------|-----------------|-----------------|
| Database | `.env` → `DATABASE_URL` | `src/lib/db/index.ts` |
| Auth provider | `.env` → `AUTH_*` | `src/lib/auth/config.ts` |
| Redis/Cache | `.env` → `REDIS_URL` | `src/lib/cache/index.ts` |

---

## Known Legacy Code (DO NOT USE)

| Path | Reason | Replacement |
|------|--------|-------------|
| `src/app/api/auth/*` | Old auth system | `src/lib/auth/` |
| `src/utils/helpers.ts` | Deprecated | `src/lib/utils/` |
| `src/components/old/*` | Pre-ShadCN | `src/components/ui/` |

---

## File Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Pages | `page.tsx` | `src/app/users/page.tsx` |
| Layouts | `layout.tsx` | `src/app/layout.tsx` |
| Components | `kebab-case.tsx` | `user-card.tsx` |
| Hooks | `use-[name].ts` | `use-auth.ts` |
| Stores | `[name]-store.ts` | `ui-store.ts` |
| Types | `[name].types.ts` | `user.types.ts` |
| Server actions | `[name]-actions.ts` | `user-actions.ts` |
| Schema | `[table].ts` | `users.ts` |

---

## How to Update This Document

1. Only update when architecture ACTUALLY changes
2. Include date and who made the change
3. If you discover this document is wrong, FIX THE DOCUMENT
4. After major refactors, review and update all sections

---

## Verification Checklist

Before modifying ANY code, verify:

- [ ] File is in the correct location per this document
- [ ] Not touching legacy/deprecated code
- [ ] Following naming conventions
- [ ] Not duplicating existing functionality
- [ ] Using correct state management approach
