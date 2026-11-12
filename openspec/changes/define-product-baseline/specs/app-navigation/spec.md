# Application navigation

## Purpose

Keep discovery and learning reachable through a small navigation model with predictable return paths and session continuity.

## ADDED Requirements

### Requirement: Global primary destinations
The application SHALL have Discover, Breeds and Settings tabs on every destination, including loading and error states. Selecting a tab SHALL open its root without stacking duplicate screens. Selecting the active tab at its root SHALL do nothing. Details SHALL highlight its originating tab.

#### Scenario: Leave Details using tabs
- **WHEN** the user selects a root tab while reading Details
- **THEN** that tab's root opens and no nested copy is added

#### Scenario: Navigate during unavailable content
- **WHEN** content is loading or has failed
- **THEN** all root tabs remain available
- **AND** selecting another tab does not imply its uncached content can load offline

### Requirement: Contextual return
Visible Back and platform Back in Details SHALL return to its origin. Discover-origin return SHALL restore the same card and breed; catalog-origin return SHALL restore the list and position. At a root view, platform Back SHALL restore the previous tab history entry; when no earlier entry remains it SHALL follow normal platform exit behavior. Direct entry to a non-Discover root SHALL retain Discover as its initial Back destination.

#### Scenario: Return from discovery details
- **WHEN** the user opens Details from Discover and then goes Back
- **THEN** the same undecided card is restored without a vote or automatic advancement

#### Scenario: Return from catalog details
- **WHEN** the user opens Details from a catalog row and then goes Back
- **THEN** the loaded catalog and its previous scroll position are restored

### Requirement: Session continuity
Switching destinations or returning from background while the session remains alive SHALL retain the current card or pending-next-card state, loaded catalog, and available details information. A late request SHALL NOT force navigation or overwrite a newer selection. Restoration after process termination is not required.

#### Scenario: Switch away during loading
- **WHEN** a user leaves a destination with a request in progress
- **THEN** completion does not pull the user back or corrupt a newer selection
- **AND** returning resumes the appropriate retained state

### Requirement: Scenario-specific controls
Voting SHALL be available only on a ready discovery card. Details entry SHALL be available from a ready discovery photograph/link or a loaded catalog row. Retry SHALL apply only to a failed content operation. Details SHALL NOT expose voting controls. No Likes collection, counter or account is included. Settings is limited to the specified appearance preference.

#### Scenario: Read without voting
- **WHEN** the user browses the catalog or reads Details
- **THEN** the user can navigate globally or return contextually but cannot vote there

### Requirement: Accessible complete journeys
All journeys SHALL work without swipes. Controls SHALL have descriptive accessibility labels and adequate touch targets. Content SHALL remain readable and controls reachable on narrow and short screens and with enlarged text; vertical scrolling SHALL accommodate long content without voting or horizontal overflow.

#### Scenario: Narrow or enlarged interface
- **WHEN** the viewport is 320 logical pixels wide or text is enlarged
- **THEN** long breed names and details remain readable and all applicable actions remain reachable
- **AND** design-reference canvas heights do not impose fixed device heights

#### Scenario: Button-only discovery
- **WHEN** the user uses only buttons and links
- **THEN** both voting decisions, details, catalog, return, and recovery journeys are available

### Requirement: Evaluation identifiers
The relevant UI elements SHALL expose the assignment identifiers cat_card, cat_breed_name, like_button, dislike_button, breeds_tab, and retry_button through Semantics. No like_counter identifier SHALL be added because counting is explicitly excluded.

#### Scenario: Inspect controls
- **WHEN** the corresponding content or recovery control is displayed
- **THEN** its required identifier is exposed for evaluation

### Requirement: Root tabs switch retained views
Discover, Breeds and Settings root tabs SHALL select views within one application shell, without pushing or popping Navigator routes. Selecting the active tab SHALL be a no-op. Mounted views SHALL retain their local state and scroll position; inactive views SHALL not receive keyboard focus or pointer interaction. Navigator remains available for contextual detail pages. Tab changes SHALL create history entries through Flutter Router. Browser Back/Forward and platform Back SHALL restore recorded tab selections without recreating the shell or retained views. Selecting the active tab SHALL not add an entry. View changes SHALL use a 200ms crossfade, disabled for reduced motion. Outgoing content SHALL immediately stop accepting input and exposing semantics.

### Requirement: Settings appearance selection
The application SHALL expose Settings in its primary navigation with Light, Dark and System appearance. System is the initial preference. Selection SHALL apply immediately throughout the application and persist across launches when local preferences storage is available.

#### Scenario: Explicit appearance and system changes
- **WHEN** Light or Dark is selected
- **THEN** the app uses that appearance independently of device brightness
- **WHEN** System is selected
- **THEN** the app follows current and subsequent device brightness changes

#### Scenario: Return from Settings
- **WHEN** the user returns to Discover through its tab or history
- **THEN** the current discovery encounter and queue are preserved
- **AND** selecting the active Settings tab does not push another route

#### Scenario: Preference restoration
- **WHEN** the app restarts after a saved selection
- **THEN** it restores the selection before first render
- **AND** unavailable storage does not prevent launch or session-local selection
