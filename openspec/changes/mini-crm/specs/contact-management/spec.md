## ADDED Requirements

### Requirement: Create a contact
The system SHALL allow authenticated users to create a contact by providing at minimum a name. Email, phone, company, role, source, and tags are optional at creation time.

#### Scenario: Create contact with name only
- **WHEN** user submits the new contact form with only a name
- **THEN** the system creates the contact and displays it in the contact list

#### Scenario: Create contact with full details
- **WHEN** user submits the new contact form with name, email, phone, company, role, source, and tags
- **THEN** the system creates the contact with all provided fields and displays it in the contact list

#### Scenario: Create contact with duplicate email
- **WHEN** user submits a new contact with an email already associated with an existing contact
- **THEN** the system warns the user of the duplicate and prompts them to confirm or cancel creation

---

### Requirement: Edit a contact
The system SHALL allow users to edit any field of an existing contact at any time.

#### Scenario: Edit contact fields
- **WHEN** user modifies one or more fields of a contact and saves
- **THEN** the system persists the changes and reflects them immediately in the contact detail view

---

### Requirement: Delete a contact
The system SHALL allow users to delete a contact. Deletion SHALL NOT delete associated deals; instead, those deals SHALL be marked as orphaned (no linked contact).

#### Scenario: Delete contact with no deals
- **WHEN** user deletes a contact that has no associated deals
- **THEN** the contact is permanently removed from the system

#### Scenario: Delete contact with associated deals
- **WHEN** user deletes a contact that has one or more associated deals
- **THEN** the contact is deleted and the associated deals remain with a null contact reference, displayed as "Contact deleted" in the deal view

---

### Requirement: Search and filter contacts
The system SHALL provide a search input that filters contacts in real time by name, email, company, or tag.

#### Scenario: Search by name
- **WHEN** user types a partial name in the search field
- **THEN** the contact list updates to show only contacts whose name contains the search string (case-insensitive)

#### Scenario: Filter by tag
- **WHEN** user selects one or more tags from the filter panel
- **THEN** the contact list shows only contacts that have all selected tags

#### Scenario: No results
- **WHEN** user's search/filter combination matches no contacts
- **THEN** the system displays an empty state message rather than a blank list

---

### Requirement: Tag contacts
The system SHALL allow users to assign one or more tags to a contact. Tags SHALL be created inline if they do not already exist.

#### Scenario: Add an existing tag to a contact
- **WHEN** user selects an existing tag from the tag picker and saves
- **THEN** the tag is associated with the contact and visible on the contact card

#### Scenario: Create and assign a new tag
- **WHEN** user types a new tag name in the tag picker and confirms
- **THEN** the system creates the tag and assigns it to the contact

---

### Requirement: Associate a contact with a company
The system SHALL allow users to associate a contact with a company. Companies SHALL be created inline if they do not already exist.

#### Scenario: Associate with existing company
- **WHEN** user selects an existing company from the company field and saves
- **THEN** the contact's company field is updated and the contact appears in the company's contact list

#### Scenario: Create and associate new company
- **WHEN** user types a new company name and confirms
- **THEN** the system creates the company record and associates it with the contact

---

### Requirement: View contact detail
The system SHALL provide a contact detail page that shows all fields, associated deals, and the full activity timeline.

#### Scenario: View contact detail
- **WHEN** user opens a contact
- **THEN** the system displays the contact's fields, a list of associated deals, and a chronological activity timeline

---

### Requirement: List all contacts
The system SHALL provide a paginated or virtualized contact list showing all contacts for the authenticated user, sortable by name, company, or creation date.

#### Scenario: View contact list
- **WHEN** user navigates to the contacts section
- **THEN** the system displays all contacts in a list, defaulting to sort by most recently created
