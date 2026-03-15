## 1. Project Setup

- [ ] 1.1 Initialize Next.js 14+ project with TypeScript and App Router
- [ ] 1.2 Install and configure Tailwind CSS
- [ ] 1.3 Install and configure shadcn/ui (init, add core components: button, input, dialog, form, dropdown-menu, table, badge, tooltip)
- [ ] 1.4 Set up PostgreSQL database (local dev via Docker Compose)
- [ ] 1.5 Install Prisma, initialize schema, configure DATABASE_URL in .env
- [ ] 1.6 Install and configure NextAuth.js with credentials provider (email + password)
- [ ] 1.7 Create base layout: authenticated shell with sidebar navigation (Contacts, Pipeline, Follow-up, Settings)
- [ ] 1.8 Add navigation badge placeholder for overdue reminders count

## 2. Data Model

- [ ] 2.1 Define Prisma schema: User, Contact, Company, Tag, ContactTag
- [ ] 2.2 Define Prisma schema: PipelineStage, Deal, DealContact
- [ ] 2.3 Define Prisma schema: Activity, Reminder
- [ ] 2.4 Run initial Prisma migration and generate client
- [ ] 2.5 Seed database with default pipeline stages (Lead, Qualified, Proposal, Won, Lost)

## 3. Contact Management

- [ ] 3.1 Build contacts list page (Server Component): paginated list sorted by created_at desc
- [ ] 3.2 Build search and tag filter UI (Client Component) with real-time filtering
- [ ] 3.3 Build "New Contact" dialog: form with name (required), email, phone, company (autocomplete), role, source, tags
- [ ] 3.4 Implement Server Action: createContact (validate required fields, check duplicate email, create record)
- [ ] 3.5 Implement Server Action: updateContact
- [ ] 3.6 Implement Server Action: deleteContact (orphan associated deals, remove contact)
- [ ] 3.7 Build contact detail page: show all fields, associated deals list, activity timeline, open reminders
- [ ] 3.8 Build inline tag creation in the tag picker (create tag if not found, assign to contact)
- [ ] 3.9 Build inline company creation in the company field

## 4. Deal Pipeline

- [ ] 4.1 Build pipeline Kanban page (Client Component): fetch stages + deals, render columns
- [ ] 4.2 Integrate dnd-kit for drag-and-drop between stage columns
- [ ] 4.3 Build deal card component: title, contact name, value, expected close date, stale indicator
- [ ] 4.4 Implement stale deal query: for each deal, compare latest Activity.createdAt (or deal.createdAt if no activities) to now minus 14 days
- [ ] 4.5 Build "New Deal" dialog: title (required), contact (required, searchable), value, expected close date, stage selector
- [ ] 4.6 Implement Server Action: createDeal
- [ ] 4.7 Implement Server Action: moveDeal (update stage, validate Won/Lost reopen rule)
- [ ] 4.8 Build "Move to stage" dropdown on deal card (mobile fallback for drag-and-drop)
- [ ] 4.9 Build "Mark as Won / Lost" action with optional reason input
- [ ] 4.10 Build "Reopen deal" action on closed deals
- [ ] 4.11 Implement Server Action: updateDeal (fields edit)
- [ ] 4.12 Implement Server Action: deleteDeal (cascade delete activities and reminders)
- [ ] 4.13 Build deal detail page: all fields, linked contact summary, stage indicator, activity timeline, open reminders
- [ ] 4.14 Add per-stage summary row: deal count + sum of values in column header

## 5. Activity Tracking

- [ ] 5.1 Build activity timeline component (shared): renders list of activities as conversation thread entries (type icon, date, notes)
- [ ] 5.2 Build "Log activity" form (inline or dialog): type selector (note, call, email, meeting), date (defaults to today), notes textarea
- [ ] 5.3 Implement Server Action: createActivity (linked to contact or deal)
- [ ] 5.4 Implement Server Action: updateActivity (edit notes, type, date)
- [ ] 5.5 Implement Server Action: deleteActivity (delete and recalculate stale status on linked deal)
- [ ] 5.6 Wire activity timeline into contact detail page
- [ ] 5.7 Wire activity timeline into deal detail page
- [ ] 5.8 Auto-log system activity on deal Won/Lost (type: "system", notes: "Deal marked Won/Lost — <reason>")

## 6. Reminders

- [ ] 6.1 Build "Add reminder" form (inline or dialog): due date (required), notes, linked entity display
- [ ] 6.2 Implement Server Action: createReminder (linked to contact or deal)
- [ ] 6.3 Implement Server Action: updateReminder (due date, notes)
- [ ] 6.4 Implement Server Action: completeReminder (set status to completed)
- [ ] 6.5 Implement Server Action: deleteReminder
- [ ] 6.6 Build follow-up queue page: list all incomplete reminders with due_date <= today, sorted ascending by due_date
- [ ] 6.7 Wire open reminders list into contact detail page (open + completed sections)
- [ ] 6.8 Wire open reminders list into deal detail page
- [ ] 6.9 Implement overdue badge count: Server Component query in navigation layout (count of incomplete reminders due_date <= today)

## 7. Data Import / Export

- [ ] 7.1 Install papaparse (server-side CSV parsing)
- [ ] 7.2 Build CSV import page: file upload input, client-side file validation (size, type)
- [ ] 7.3 Implement import API route (POST /api/import/contacts): parse CSV server-side, return column headers for mapping step
- [ ] 7.4 Build field-mapping step UI: map CSV columns to contact fields, require name mapping
- [ ] 7.5 Build import preview table: show first N rows with mapped values, flag duplicate emails (within file and vs. existing contacts)
- [ ] 7.6 Implement import confirm action: create contacts for valid non-duplicate rows, report created count and skipped count
- [ ] 7.7 Implement contacts CSV export: Server Action or API route that streams CSV of all (or filtered) contacts
- [ ] 7.8 Implement deals CSV export: Server Action or API route that streams CSV of all deals (title, value, stage, expected close, contact name, created date)
- [ ] 7.9 Add "Import" and "Export" buttons to contacts list page
- [ ] 7.10 Add "Export deals" button to pipeline page

## 8. Polish and Verification

- [ ] 8.1 Add loading states (skeleton loaders) to contacts list, pipeline board, and follow-up queue
- [ ] 8.2 Add empty states to contacts list, pipeline columns, follow-up queue, and activity timelines
- [ ] 8.3 Verify contact duplicate email warning on manual create (not just import)
- [ ] 8.4 Verify orphaned deal display ("Contact deleted") in deal views
- [ ] 8.5 Verify Won/Lost deals are excluded from active Kanban board but accessible via a "Closed deals" filter or list
- [ ] 8.6 Verify stale indicator appears and clears correctly when activities are added/deleted
- [ ] 8.7 Verify overdue badge updates after completing reminders
- [ ] 8.8 Test CSV import with: valid file, invalid file, duplicate emails within file, duplicate emails vs. existing contacts, missing name column
- [ ] 8.9 Test CSV export (contacts and deals) with data present and with empty state
- [ ] 8.10 Verify responsive layout on mobile viewport for contacts list, pipeline board (horizontal scroll), and follow-up queue
