# Breed information

## Purpose

Provide a complete breed catalog and consistent, truthful information for either a selected breed or a displayed discovery image.

## ADDED Requirements

### Requirement: Contextual single breed identity
Where one breed identity is required for an image, the application SHALL use the first listed API breed. It SHALL preserve the full association list and SHALL NOT apply this selection rule to the catalog. An empty or unusable first breed SHALL make that discovery record unusable. The record SHALL be skipped without fabricated facts or selection of a later breed; batch recovery applies only when no usable records remain or the response structure is invalid.

#### Scenario: Multiple associated breeds
- **WHEN** an image has multiple breeds
- **THEN** its discovery label and associated Details identify the first listed breed consistently
- **AND** other associations remain intact

#### Scenario: No usable breed
- **WHEN** an image lacks a usable first breed identity
- **THEN** that record is skipped and is not presented as a ready discovery card
- **AND** other usable records remain available; Retry is offered only if the batch has no usable records and no queued content remains

### Requirement: Complete catalog
The Breeds destination SHALL show all available valid breeds in alphabetical order, not only the illustrated examples. Each entire breed row SHALL open information for that breed.

#### Scenario: Select a catalog breed
- **WHEN** the user selects a loaded breed row
- **THEN** Details shows that selected breed's information without changing discovery or voting

### Requirement: Shared contextual details
Details SHALL share the full breed-information UI across entry contexts; separate pages with shared widgets are permitted. Discover entry SHALL retain the queue-head image at navigation time and its selected breed without consuming the encounter. Catalog entry SHALL use the selected breed and a representative image when available. Missing photographs SHALL NOT block breed information.

#### Scenario: Inspect current cat
- **WHEN** the user taps the ready discovery photograph or View breed details
- **THEN** Details shows that same image identity and the selected breed information
- **AND** no replacement image is fetched merely to open Details

#### Scenario: Shared content across page contexts
- **WHEN** details are entered from Discover or the breed catalog
- **THEN** the same full information hierarchy is available with context-specific data
- **AND** the originating tab is highlighted and Back returns to that origin

#### Scenario: Catalog entry without a photograph
- **WHEN** the selected catalog breed has no available representative photograph
- **THEN** its description and available facts remain readable

### Requirement: Complete relevant information
Details SHALL present the description and four key fact positions: origin, life span, coat, and temperament. It SHALL expose available fuller breed information below, including personality, history, ratings, additional characteristics, and relevant facts such as weight. Internal IDs and raw JSON are not user-facing breed information.

#### Scenario: Supplied breed information
- **WHEN** relevant information is supplied by the source
- **THEN** Details exposes it without a separate brief-to-full-details navigation step
- **AND** shortened temperament in key facts does not remove the full supplied value below

### Requirement: Truthful unavailable information
Missing facts SHALL appear as Not provided. The app SHALL NOT infer coat, invent history, replace missing ratings with zero, or replace unknown booleans with No. Ratings SHALL include numerical values and understandable direction; values and units SHALL follow the source.

#### Scenario: Partial source record
- **WHEN** optional facts or ratings are absent or invalid
- **THEN** available information remains usable and unavailable fields are explicitly distinguished from negative or zero values
- **AND** unknown additional API fields do not break Details
