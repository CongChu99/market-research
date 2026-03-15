## ADDED Requirements

### Requirement: Set a reminder on a contact or deal
The system SHALL allow users to set a follow-up reminder on any contact or deal, specifying a due date and optional notes.

#### Scenario: Set a reminder on a contact
- **WHEN** user creates a reminder with a due date on a contact
- **THEN** the reminder is saved and appears in the contact detail view under open reminders

#### Scenario: Set a reminder on a deal
- **WHEN** user creates a reminder with a due date on a deal
- **THEN** the reminder is saved and appears in the deal detail view under open reminders

#### Scenario: Set a reminder without notes
- **WHEN** user creates a reminder with only a due date (no notes)
- **THEN** the system creates the reminder with a blank notes field

---

### Requirement: Surface overdue reminders in a follow-up queue
The system SHALL provide a follow-up queue view that lists all reminders whose due date is today or in the past and have not been completed. Overdue reminders SHALL appear at the top, sorted by due date ascending.

#### Scenario: View follow-up queue with overdue items
- **WHEN** user opens the follow-up queue
- **THEN** the system displays all incomplete reminders with due dates on or before today, sorted oldest-first

#### Scenario: View follow-up queue with no overdue items
- **WHEN** user has no overdue or due-today reminders
- **THEN** the queue shows an empty state indicating no follow-ups are due

#### Scenario: Follow-up queue shows linked entity
- **WHEN** a reminder is listed in the queue
- **THEN** each item displays the linked contact name or deal title, the due date, and the reminder notes

---

### Requirement: Complete a reminder
The system SHALL allow users to mark a reminder as complete. Completed reminders SHALL be removed from the follow-up queue but remain accessible in the contact or deal's reminder history.

#### Scenario: Complete a reminder from the queue
- **WHEN** user marks a reminder as complete from the follow-up queue
- **THEN** the reminder is removed from the queue and its status is updated to completed

#### Scenario: Complete a reminder from a contact/deal
- **WHEN** user marks a reminder as complete from the contact or deal detail view
- **THEN** the reminder moves from the open reminders list to the completed reminders section on that record

---

### Requirement: Edit a reminder
The system SHALL allow users to change the due date or notes of an existing reminder before it is completed.

#### Scenario: Reschedule a reminder
- **WHEN** user changes the due date of an open reminder and saves
- **THEN** the reminder reflects the new due date in the queue and on the linked record

---

### Requirement: Delete a reminder
The system SHALL allow users to delete a reminder. Deletion is permanent.

#### Scenario: Delete a reminder
- **WHEN** user confirms deletion of a reminder
- **THEN** the reminder is permanently removed from the system and no longer appears in the queue or on the linked record

---

### Requirement: Upcoming reminders badge
The system SHALL display a count badge in the navigation showing the number of overdue or due-today reminders whenever that count is greater than zero.

#### Scenario: Reminders badge with due items
- **WHEN** there are one or more reminders due today or overdue
- **THEN** the navigation shows a badge with the count

#### Scenario: Reminders badge clears
- **WHEN** all due and overdue reminders are completed or rescheduled to a future date
- **THEN** the badge is no longer displayed
