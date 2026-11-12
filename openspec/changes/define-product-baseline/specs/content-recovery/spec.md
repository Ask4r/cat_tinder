# Content recovery

## Purpose

Make image and breed loading failures understandable and recoverable without losing usable content or interrupting unrelated activities.

## ADDED Requirements

### Requirement: Bounded content loading
Content operations SHALL show loading while pending and end in usable content or an understandable error within a finite timeout. The initial product target is at most 15 seconds per visible attempt. No content attempt SHALL cause an infinite spinner or unbounded automatic retry loop.

#### Scenario: Slow response
- **WHEN** a content response exceeds the timeout
- **THEN** loading ends in a recoverable error and navigation remains available

#### Scenario: No prepared card
- **WHEN** a decision advances discovery before its next usable image is ready
- **THEN** discovery shows loading, followed by the new card or its error state
- **AND** it does not wait for the vote response

### Requirement: Recoverable content errors
No network, connection loss, HTTP errors, invalid response structures, and discovery batches with no usable records SHALL produce understandable content errors with Retry. Discovery responses SHALL be lists. Within a valid list, malformed or unusable records SHALL be skipped silently; usable records SHALL be kept in source order, including repeated image IDs. A partially usable batch SHALL NOT itself trigger recovery or an alert. Existing queued content SHALL remain usable when a later batch fails. Missing or rejected configuration credentials SHALL explain unavailable service access without asking the user to enter a key. Errors SHALL NOT expose raw exceptions or cause unhandled failures.

#### Scenario: Partially usable discovery batch
- **WHEN** a discovery response is a list containing both usable and malformed or unusable records
- **THEN** only the usable records are appended in their original order
- **AND** invalid records are skipped without votes, alerts, or recovery UI
- **AND** valid records with repeated image IDs remain separate encounters

#### Scenario: No usable discovery records
- **WHEN** the response list is empty or no usable records remain after filtering
- **THEN** the content operation fails with Retry
- **AND** any existing usable queue remains available, with blocking recovery shown only after exhaustion

#### Scenario: Invalid discovery response structure
- **WHEN** the response is not a list or cannot be decoded as JSON
- **THEN** the content operation fails with Retry rather than treating the response as a discovery record
- **AND** any existing usable queue remains available until exhaustion

#### Scenario: Offline startup or mid-session outage
- **WHEN** fetching content fails without usable results
- **THEN** the affected destination shows an error and Retry while retaining global navigation

#### Scenario: Configuration failure
- **WHEN** service access fails due to missing or rejected credentials
- **THEN** the app explains that access is unavailable and remains navigable without displaying secret values

### Requirement: Unobtrusive queue refill failure
A failed background refill SHALL NOT interrupt usable queued discovery cards or display blocking recovery while those cards remain available. Once the queue is exhausted, an unresolved refill failure SHALL produce the dedicated discovery error UI with Retry. A pending refill with no usable card SHALL use bounded loading. Cancellation or failure SHALL NOT leave refill permanently marked in progress.

#### Scenario: Refill fails before exhaustion
- **WHEN** refill fails but usable queued cards remain
- **THEN** the user continues discovery without a blocking error or alert
- **AND** exhaustion without recovered content reveals the discovery error with Retry

### Requirement: Scoped idempotent content retry
Retry SHALL repeat only the failed content operation without restarting the app, replaying a vote, or resetting retained successful data. Repeated Retry input SHALL NOT produce conflicting visible results. Already loaded catalog and details content SHALL remain usable when later requests fail.

#### Scenario: Failed next-card request
- **WHEN** the user retries after deciding the previous card
- **THEN** the app requests the next card without submitting the previous decision again

#### Scenario: Failed details enrichment
- **WHEN** additional breed information fails to load
- **THEN** the selected image and available facts remain readable with scoped Retry and Back

### Requirement: Image-specific recovery
A failed photograph SHALL have image-specific recovery. Discovery SHALL offer retry of the same photograph or skip without voting. Details SHALL retain readable information and offer image retry without substituting a different discovery-origin image.

#### Scenario: Discovery photograph fails
- **WHEN** a discovery photograph cannot load
- **THEN** voting is unavailable and the user can retry that image, skip without a vote, or use global navigation

#### Scenario: Details photograph fails
- **WHEN** the details photograph cannot load
- **THEN** available text remains readable and retry preserves the intended image identity

### Requirement: Failure isolation
A vote-endpoint failure SHALL NOT trigger content failure UI. A content-endpoint failure SHALL NOT be hidden merely because voting is best effort. Leaving a screen during any request SHALL NOT cause an unhandled failure.

#### Scenario: Independent endpoint outcomes
- **WHEN** voting fails while discovery succeeds, or discovery fails while voting succeeds
- **THEN** only the discovery failure, if any, receives user-facing recovery
- **AND** vote delivery never controls content navigation or recovery
