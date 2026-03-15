## ADDED Requirements

### Requirement: Create a deal
The system SHALL allow users to create a deal with a title and a linked contact. Value, expected close date, and stage are optional at creation; stage defaults to the first active pipeline stage if not specified.

#### Scenario: Create deal with required fields only
- **WHEN** user submits a new deal with a title and linked contact
- **THEN** the system creates the deal in the default pipeline stage and displays it on the Kanban board

#### Scenario: Create deal with all fields
- **WHEN** user submits a new deal with title, contact, value, expected close date, and stage
- **THEN** the system creates the deal with all fields and places it in the specified stage

#### Scenario: Attempt to create deal without a contact
- **WHEN** user attempts to submit a new deal without selecting a contact
- **THEN** the system displays a validation error and does not create the deal

---

### Requirement: View pipeline as Kanban board
The system SHALL display all open deals in a Kanban board with one column per pipeline stage. Each deal card SHALL show title, contact name, deal value, and expected close date.

#### Scenario: View Kanban board
- **WHEN** user navigates to the pipeline view
- **THEN** the system displays all non-closed deals grouped by stage in column format

#### Scenario: View Kanban board with no deals
- **WHEN** user has no deals
- **THEN** each stage column shows an empty state prompt to add a deal

---

### Requirement: Move a deal between stages
The system SHALL allow users to move a deal to a different pipeline stage via drag-and-drop or a stage selector dropdown.

#### Scenario: Drag deal to another stage
- **WHEN** user drags a deal card and drops it in a different stage column
- **THEN** the deal's stage is updated and the card appears in the new column

#### Scenario: Move deal via dropdown (mobile-friendly fallback)
- **WHEN** user opens a deal's action menu and selects "Move to stage" and chooses a stage
- **THEN** the deal's stage is updated

---

### Requirement: Close a deal as Won or Lost
The system SHALL allow users to mark a deal as Won or Lost. A closed deal SHALL be removed from the active Kanban board and logged with a close reason.

#### Scenario: Mark deal as Won
- **WHEN** user selects "Mark as Won" on a deal
- **THEN** the deal stage changes to Won, the deal is removed from the active Kanban board, and an activity entry is logged with outcome "Deal Won"

#### Scenario: Mark deal as Lost
- **WHEN** user selects "Mark as Lost" and optionally provides a reason
- **THEN** the deal stage changes to Lost, the deal is removed from the active Kanban board, and an activity entry is logged with the reason

#### Scenario: Reopen a closed deal
- **WHEN** user explicitly selects "Reopen" on a closed deal
- **THEN** the deal is moved back to the first active pipeline stage and restored on the Kanban board

---

### Requirement: Detect and display stale deals
The system SHALL visually flag deals that have had no activity logged within the stale threshold (default: 14 days). Stale deals SHALL be highlighted on the Kanban board with a visual indicator.

#### Scenario: Deal with no recent activity
- **WHEN** a deal's most recent activity is older than the stale threshold
- **THEN** the deal card displays a stale indicator (e.g., a warning icon or color change)

#### Scenario: Deal with no activity at all
- **WHEN** a deal has never had any activity logged and was created more than the stale threshold ago
- **THEN** the deal card displays the stale indicator

#### Scenario: Deal with recent activity
- **WHEN** a deal has an activity logged within the stale threshold
- **THEN** the deal card shows no stale indicator

---

### Requirement: Edit a deal
The system SHALL allow users to edit deal fields (title, value, expected close date, linked contact) from the deal detail view.

#### Scenario: Edit deal fields
- **WHEN** user modifies deal fields and saves
- **THEN** the system persists all changes and reflects them on the Kanban board and deal detail view

---

### Requirement: Delete a deal
The system SHALL allow users to delete a deal. Deleting a deal SHALL also delete all associated activities and reminders.

#### Scenario: Delete a deal
- **WHEN** user confirms deletion of a deal
- **THEN** the deal, its activities, and its reminders are permanently removed

---

### Requirement: View deal detail
The system SHALL provide a deal detail page showing all deal fields, the linked contact, a pipeline stage indicator, the activity timeline, and open reminders.

#### Scenario: View deal detail
- **WHEN** user opens a deal
- **THEN** the system displays all deal fields, the linked contact summary, the current stage, the activity timeline, and any open reminders

---

### Requirement: Pipeline summary
The system SHALL display aggregate deal value per stage on the pipeline view (sum of deal values for deals in each stage, excluding deals with no value set).

#### Scenario: View pipeline value summary
- **WHEN** user views the Kanban board
- **THEN** each stage column header shows the count of deals and the total value of deals with a set value in that stage
