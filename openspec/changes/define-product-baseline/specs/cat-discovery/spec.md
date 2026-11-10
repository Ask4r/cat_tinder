# Cat discovery

## Purpose

Let people browse random cat photographs and express preferences without waiting for remote vote confirmation.

## ADDED Requirements

### Requirement: Usable discovery card
Discover SHALL show a random API image and its associated breed name. A ready card SHALL have a usable photograph and breed identity. The application SHALL prepare the next image and photograph ahead of the next action when possible.

#### Scenario: First launch
- **WHEN** the app opens
- **THEN** Discover loads a random cat and shows its photograph and breed once usable
- **AND** content loading does not disable navigation

#### Scenario: Prepared next card
- **WHEN** the current encounter is decided and a prepared card is ready
- **THEN** the next card appears without waiting for vote confirmation or showing an intervening loading alert

### Requirement: Shared discovery queue
The application SHALL own an ordered session queue of image entities whose head is the current image. A successful refill SHALL append entities without replacing queued encounters. Low-water refill and photograph preloading near the head SHALL prepare future cards. No explicit queue capacity, discovery history, or image-ID duplicate check is required. Each accepted vote SHALL capture the head for submission and pop that encounter exactly once.

#### Scenario: Refill while browsing
- **WHEN** a refill completes while cards remain queued
- **THEN** its results append without changing the current head
- **AND** that retrieval execution is consumed only once even if listeners remount or cached results are observed again

#### Scenario: Overlapping refill triggers
- **WHEN** multiple consumers or transitions trigger the same pending refill
- **THEN** no unintended redundant refill or repeated consumption occurs
- **AND** repeated image IDs returned by the API remain separate valid encounters

### Requirement: Equivalent primary decisions
Like and Dislike SHALL be the primary product actions, available only on a ready, undecided discovery card. Like/button or right swipe SHALL submit a positive image vote; Dislike/button or left swipe SHALL submit a negative image vote. Both SHALL advance discovery.

#### Scenario: Like
- **WHEN** the user presses Like or completes a right swipe
- **THEN** one positive vote submission is attempted for the displayed image and discovery advances

#### Scenario: Dislike
- **WHEN** the user presses Dislike or completes a left swipe
- **THEN** one negative vote submission is attempted for the displayed image and discovery advances

### Requirement: One decision per encounter
The application SHALL accept only the first decision for a displayed encounter. It SHALL NOT queue repeated decisions during its transition. It SHALL distinguish photograph taps, voting gestures, cancelled gestures, and vertical scrolling.

#### Scenario: Rapid or overlapping input
- **WHEN** multiple taps or gestures target a card being decided or replaced
- **THEN** that encounter produces only one vote attempt and one progression

#### Scenario: Non-voting gestures
- **WHEN** the user taps the photograph, scrolls vertically, or cancels a swipe
- **THEN** no vote is submitted
- **AND** only a photograph tap opens Details

#### Scenario: Repeat image
- **WHEN** the API returns an image seen in an earlier encounter, including the immediately previous one
- **THEN** the app treats it as a new encounter without duplicate checks or suppression
- **AND** the next deliberate decision can submit another vote

### Requirement: Independent best-effort voting
Vote submission SHALL run independently of discovery. Success, failure, or uncertain delivery SHALL NOT block navigation, revert a decision, show an alert, or trigger content-error UI. Failures SHALL be handled without unhandled exceptions. No delivery guarantee, automatic resubmission, or persistent delivery queue is required.

#### Scenario: Slow or failed vote
- **WHEN** the vote endpoint is slow, fails, or returns an uncertain outcome
- **THEN** discovery remains usable and advances as soon as its next card is available
- **AND** the app neither claims confirmed delivery nor offers vote retry

#### Scenario: Next image fails after a decision
- **WHEN** vote submission is attempted but fetching the next card fails
- **THEN** the discovery recovery state appears independently of the vote outcome
- **AND** retrying content does not resubmit the vote

### Requirement: No like counting
The application SHALL NOT display, calculate, aggregate, retrieve for counting, or locally track like counts in any form. It SHALL NOT introduce identity or vote-history features solely for counting.

#### Scenario: Any vote outcome or destination
- **WHEN** a user votes, revisits a breed or image, or opens any destination
- **THEN** no image, breed, user, session, or global like counter is shown or maintained
