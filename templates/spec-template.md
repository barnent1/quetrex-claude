# Spec: [Feature Name]

## Overview
[Brief description of what this feature does and why]

## User Stories
- As a [user type], I want [goal] so that [benefit]
- As a [user type], I want [goal] so that [benefit]

## Data Model

### New Tables
```typescript
// db/schema/[feature].ts
export const [table] = pgTable('[table_name]', {
  id: uuid('id').primaryKey().defaultRandom(),
  // Add fields here
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
});

export type [Type] = typeof [table].$inferSelect;
export type New[Type] = typeof [table].$inferInsert;
```

### Relations
[Describe how this relates to existing tables]

## API Design

### Server Actions
```typescript
// actions/[feature]-actions.ts
'use server'

export async function create[Feature](data: Create[Feature]Input): Promise<ActionResult<[Type]>>
export async function get[Feature]s(filters?: [Feature]Filters): Promise<[Type][]>
export async function update[Feature](id: string, data: Update[Feature]Input): Promise<ActionResult<[Type]>>
export async function delete[Feature](id: string): Promise<ActionResult<void>>
```

### Validation Schemas
```typescript
export const create[Feature]Schema = z.object({
  // Define fields
});
```

## Component Structure

```
components/[feature]/
├── index.ts
├── [feature]-list.tsx
├── [feature]-card.tsx
├── [feature]-form.tsx
├── [feature]-dialog.tsx
└── use-[feature].ts
```

## Test Plan

### Unit Tests
```typescript
describe('[feature]', () => {
  describe('create[Feature]', () => {
    it('should create with valid data', async () => {
      // Test implementation
    });

    it('should reject invalid data', async () => {
      // Test implementation
    });
  });

  describe('get[Feature]s', () => {
    it('should return all items', async () => {
      // Test implementation
    });

    it('should filter by criteria', async () => {
      // Test implementation
    });
  });
});
```

### Integration Tests
- [ ] Create flow: form → action → database → UI update
- [ ] Read flow: database → server component → render
- [ ] Update flow: form → action → database → UI update
- [ ] Delete flow: confirm → action → database → UI update

## Implementation Order

1. [ ] Database schema + migration
2. [ ] TypeScript types
3. [ ] Validation schemas
4. [ ] Server actions
5. [ ] Write tests (expect failures)
6. [ ] React Query hooks
7. [ ] UI components
8. [ ] Wire up pages
9. [ ] Tests should pass
10. [ ] Manual QA

## Notes
[Any additional considerations, edge cases, or decisions]
