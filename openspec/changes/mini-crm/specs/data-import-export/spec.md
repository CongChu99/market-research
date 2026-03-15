## ADDED Requirements

### Requirement: Import contacts from CSV
The system SHALL allow users to upload a CSV file of contacts. The system SHALL present a field-mapping step before importing, allowing the user to map CSV columns to contact fields. Import SHALL deduplicate on email address.

#### Scenario: Upload a valid CSV and map fields
- **WHEN** user uploads a CSV file and maps columns to contact fields (at minimum: name)
- **THEN** the system displays a preview of the rows to be imported with the mapped values

#### Scenario: Confirm and execute import
- **WHEN** user reviews the preview and confirms the import
- **THEN** the system creates new contact records for all valid rows and reports the count of contacts created

#### Scenario: CSV contains duplicate emails
- **WHEN** one or more rows in the CSV share an email address with an existing contact
- **THEN** the import preview flags those rows as duplicates and the user can choose to skip or overwrite each

#### Scenario: CSV contains rows with duplicate emails within the file itself
- **WHEN** two or more rows in the uploaded CSV share the same email address
- **THEN** the system flags the rows in the preview; only one contact is created per email on confirm

#### Scenario: Upload file that is not a valid CSV
- **WHEN** user uploads a file that cannot be parsed as CSV
- **THEN** the system displays an error and does not proceed to the mapping step

#### Scenario: CSV with no name column mappable
- **WHEN** user cannot map any column to the required "name" field
- **THEN** the system prevents confirmation and shows a validation error indicating name is required

---

### Requirement: Export contacts to CSV
The system SHALL allow users to export all contacts (or a filtered subset) to a CSV file. The exported CSV SHALL include all contact fields.

#### Scenario: Export all contacts
- **WHEN** user triggers "Export contacts" with no filter active
- **THEN** the system downloads a CSV containing all contact records with headers for each field

#### Scenario: Export filtered contacts
- **WHEN** user triggers "Export contacts" while a search or tag filter is active
- **THEN** the exported CSV contains only the contacts matching the current filter

#### Scenario: Export with no contacts
- **WHEN** user triggers export and has no contacts
- **THEN** the system downloads a CSV containing only the header row

---

### Requirement: Export deals to CSV
The system SHALL allow users to export all deals to a CSV file. The exported CSV SHALL include deal title, value, stage, expected close date, linked contact name, and created date.

#### Scenario: Export all deals
- **WHEN** user triggers "Export deals"
- **THEN** the system downloads a CSV containing all deal records with the defined headers

#### Scenario: Export with no deals
- **WHEN** user triggers deal export and has no deals
- **THEN** the system downloads a CSV containing only the header row
