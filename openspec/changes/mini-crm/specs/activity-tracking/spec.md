## ADDED Requirements

### Requirement: Log an activity on a contact or deal
The system SHALL allow users to log an activity (note, call, email, or meeting) against a contact or a deal. Each activity SHALL record type, date, and free-text notes.

#### Scenario: Log a note on a contact
- **WHEN** user submits an activity of type "note" with text content on a contact
- **THEN** the activity appears at the top of the contact's activity timeline with the current date and "Note" type label

#### Scenario: Log a call on a deal
- **WHEN** user submits an activity of type "call" with optional notes on a deal
- **THEN** the activity appears in the deal's activity timeline with the current date and "Call" type label

#### Scenario: Log activity with a custom date
- **WHEN** user specifies a date other than today when logging an activity
- **THEN** the activity is recorded with the user-specified date and appears in chronological order in the timeline

---

### Requirement: Display activity timeline as a conversation thread
The system SHALL display all activities for a contact or deal in a chronological (oldest-to-newest) list styled as a conversation thread, with each entry showing type, date, and notes.

#### Scenario: View activity timeline on contact
- **WHEN** user opens a contact detail page
- **THEN** the system displays all activities linked to that contact in chronological order, rendered as a thread of entries

#### Scenario: View activity timeline on deal
- **WHEN** user opens a deal detail page
- **THEN** the system displays all activities linked to that deal in chronological order

#### Scenario: Empty timeline
- **WHEN** a contact or deal has no activities logged
- **THEN** the timeline shows an empty state prompt encouraging the user to log their first touchpoint

---

### Requirement: Edit an activity
The system SHALL allow users to edit the notes, type, and date of any activity they have logged.

#### Scenario: Edit activity notes
- **WHEN** user edits the notes of an existing activity and saves
- **THEN** the activity is updated and the new notes are reflected in the timeline

---

### Requirement: Delete an activity
The system SHALL allow users to delete an activity. Deletion is permanent and cannot be undone.

#### Scenario: Delete an activity
- **WHEN** user confirms deletion of an activity
- **THEN** the activity is removed from the timeline and the deal's last-activity date is recalculated

---

### Requirement: Activity contributes to stale deal calculation
The system SHALL use the most recent activity date for a deal to determine whether that deal is stale. An activity logged on a deal SHALL reset the stale timer for that deal.

#### Scenario: Log activity on stale deal
- **WHEN** user logs a new activity on a deal that was previously flagged as stale
- **THEN** the stale indicator is removed from that deal on the Kanban board

#### Scenario: Delete the only recent activity on a deal
- **WHEN** user deletes an activity that was the most recent one on a deal, and no other activity within the stale threshold exists
- **THEN** the deal is re-evaluated and may be re-flagged as stale
