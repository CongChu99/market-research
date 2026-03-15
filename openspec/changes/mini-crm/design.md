## Context

This is a greenfield web application. There is no existing codebase. The product is a minimal CRM targeting freelancers, solo operators, and micro-businesses (1–5 people) who need contact management, a deal pipeline, activity logging, and follow-up reminders without the complexity or cost of HubSpot, Pipedrive, or Salesforce. The MVP is single-user; multi-user is deferred to v2.

## Goals / Non-Goals

**Goals:**
- Zero-configuration onboarding — user can add a contact and create a deal within 60 seconds of first login
- Core data model: Contact, Company, Deal, Activity, Reminder, Pipeline Stage, Tag
- Kanban pipeline with stale deal detection
- Conversation-style activity timeline per contact/deal
- Follow-up reminder queue surfacing overdue items
- CSV import (contacts) and CSV export (contacts + deals)
- Web-first, responsive enough to use on mobile

**Non-Goals (v1):**
- Email sync (Gmail / Outlook integration)
- Multi-user / team features
- Contact enrichment via third-party API
- Native mobile app
- Automation / webhooks / Zapier integration
- Self-hosting / open-source distribution
- Reporting beyond basic pipeline value summary

## Decisions

### 1. Full-stack framework: Next.js (App Router) + TypeScript

**Decision:** Use Next.js 14+ with the App Router, React Server Components for data-fetching pages, and Client Components only where interactivity is needed.

**Rationale:** Next.js collocates frontend and backend (API routes / Server Actions), reducing the number of moving parts for a solo greenfield build. The App Router's server-first model keeps data fetching simple — no separate API layer needed for most views.

**Alternatives considered:**
- Remix: Similar server-first model but smaller ecosystem and less Next.js momentum in 2025.
- SvelteKit: Excellent DX but smaller talent pool and fewer UI component libraries.
- Separate React SPA + Express API: More deployment complexity, no benefit at this scale.

---

### 2. Database: PostgreSQL via Prisma ORM

**Decision:** PostgreSQL as the primary datastore; Prisma for schema management, migrations, and type-safe queries.

**Rationale:** The data model is relational (contacts → deals → activities → reminders). PostgreSQL handles this cleanly. Prisma generates TypeScript types from the schema, eliminating a class of runtime errors and keeping the codebase maintainable as the schema evolves.

**Alternatives considered:**
- SQLite: Simpler local setup but poor fit for hosted SaaS (concurrent writes, replication).
- MongoDB: Schema flexibility not needed; relational queries (e.g., "deals with no activity in 14 days") are more natural in SQL.
- Supabase (Postgres-as-a-service): Valid option, but using raw Postgres + Prisma keeps infrastructure provider-agnostic.

---

### 3. Authentication: NextAuth.js (credentials + OAuth)

**Decision:** Use NextAuth.js with email/password (credentials provider) and optional Google OAuth for v1.

**Rationale:** NextAuth integrates directly with the Next.js session model and handles token rotation, CSRF, and session persistence out of the box. Single-user MVP means no complex RBAC is needed.

**Alternatives considered:**
- Clerk: Excellent UX but paid beyond dev tier; adds vendor dependency for auth.
- Auth0: Same concern — external vendor dependency for a core function.
- Custom JWT: More control but significantly more surface area for auth bugs.

---

### 4. UI component library: shadcn/ui + Tailwind CSS

**Decision:** Use shadcn/ui for base components (dialogs, forms, tables, dropdowns) and Tailwind CSS for layout and custom styles.

**Rationale:** shadcn/ui components are copied into the project (not a dependency), making them fully customizable without fighting an upstream library. Tailwind keeps CSS co-located with components and eliminates stylesheet sprawl.

**Alternatives considered:**
- Chakra UI / MUI: Runtime CSS-in-JS overhead; harder to customize at the component level.
- Radix Primitives directly: More work than shadcn/ui for no additional control.

---

### 5. Kanban board: dnd-kit

**Decision:** Use `dnd-kit` for drag-and-drop on the pipeline Kanban board.

**Rationale:** `dnd-kit` is the de facto standard for accessible drag-and-drop in React. It is headless (no UI opinions), lightweight, and handles touch events for mobile use.

**Alternatives considered:**
- react-beautiful-dnd: Officially deprecated; no maintenance.
- react-dnd: Older API, less active development.

---

### 6. Stale deal detection: database-computed, rendered client-side

**Decision:** Stale deals are identified by querying `Activity.createdAt` for the most recent activity per deal. If no activity exists within a configurable threshold (default: 14 days), the deal is flagged on render. No background job needed.

**Rationale:** At small data volumes (dozens to low hundreds of deals per user), this is a simple SQL query on page load. A cron job or background worker would add infrastructure complexity not warranted at this scale.

**Trade-off:** At very high deal volume (1,000+), this query may slow down. Acceptable for v1; can add a materialized column in v2 if needed.

---

### 7. CSV import: server-side streaming parse

**Decision:** Parse uploaded CSV files on the server using `papaparse` (server-side). Validate rows, detect duplicates by email, return a preview for user confirmation before committing.

**Rationale:** Browser-side parsing is fine for small files but server-side processing keeps the validation logic in one place and allows rejecting malformed uploads before any state changes.

## Risks / Trade-offs

- **No email sync in v1** → Users must manually log touchpoints. This is the most common CRM complaint. Mitigation: Make manual logging as fast as possible (1-click activity entry); position email sync as a clearly-communicated v2 feature.
- **Single-user only in v1** → Blocks micro-agency use case identified in market analysis. Mitigation: Design data model with `userId` / `ownerId` on all entities from day one so multi-user is additive, not a rewrite.
- **No mobile app** → Mobile UX relies on responsive web. Mitigation: Prioritize mobile-friendly quick-add flow as a PWA installable shortcut.
- **Prisma migration complexity** → Schema changes require careful migration scripts in production. Mitigation: Use Prisma Migrate with explicit migration files; never use `db push` in production.
- **dnd-kit on touch devices** → Drag-and-drop on mobile is less reliable. Mitigation: Provide a "Move to stage" dropdown as an alternative to dragging for mobile users.

## Open Questions

- Should the pipeline stages be fixed (Lead → Qualified → Proposal → Won/Lost) or fully user-configurable in v1? Fixed stages reduce scope significantly; configurable stages are a common power-user request.
- What is the stale deal threshold — fixed at 14 days or user-configurable per pipeline?
- Should "reminder" notifications be in-app only (v1) or also email notifications?
