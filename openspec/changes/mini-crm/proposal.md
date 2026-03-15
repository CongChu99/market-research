## Why

Freelancers, solo operators, and micro-businesses lose deals and client relationships because existing CRM tools are either too complex to set up (HubSpot, Salesforce) or too expensive for a single user (Pipedrive, Folk). They fall back to spreadsheets, which break down as soon as follow-ups need to be tracked. A mini CRM gives them just enough structure — contacts, a deal pipeline, activity history, and reminders — with zero configuration required and a pricing model that doesn't penalize solo use.

## What Changes

- Introduce a **contact management** capability: add, search, tag, and manage contacts with company associations
- Introduce a **deal pipeline** capability: kanban-style pipeline with configurable stages, deal values, and close dates
- Introduce an **activity tracking** capability: log notes, calls, and meetings against contacts or deals; conversation-style timeline view
- Introduce a **reminders and follow-up** capability: set follow-up dates on contacts and deals; surface overdue items in a daily queue
- Introduce a **data import/export** capability: CSV import for contacts with deduplication, CSV export for contacts and deals

## Capabilities

### New Capabilities

- `contact-management`: Create, edit, search, tag, and organize contacts; associate contacts with companies; track contact source and metadata
- `deal-pipeline`: Manage deals through a kanban pipeline with stages, values, expected close dates, and Won/Lost outcomes; detect stale deals with no recent activity
- `activity-tracking`: Log touchpoints (notes, calls, meetings) against contacts or deals; display history as a chronological conversation-style timeline
- `reminders`: Set and manage follow-up reminders tied to contacts or deals; surface overdue reminders in a prioritized daily queue
- `data-import-export`: Import contacts from CSV with field mapping and email-based deduplication; export contacts and deals to CSV

### Modified Capabilities

## Impact

- New web application (no existing codebase — greenfield)
- Core data layer: Contact, Company, Deal, Activity, Reminder, Pipeline Stage, Tag entities
- User authentication required (single-user MVP; multi-user deferred to v2)
- No external API integrations in v1 (email sync, enrichment, calendar deferred)
- Deployable as a hosted SaaS; self-hosting path not required for v1
