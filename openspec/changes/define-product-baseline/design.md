# Product decisions and user flows

## Context

See [proposal.md](proposal.md) for scope and the explicit no-counter coursework deviation. The inspected project is a Flutter starter with no existing OpenSpec capabilities. These are intended behaviors, not claims about the running app. User authorization covers documentation only.

The standard OpenSpec design artifact is used here for product-level decisions. Architecture, project layout, state management, networking/image libraries, runtime versions, and toolchain remain deferred to a later engineering stage. This artifact is not a technical implementation design.

## Goals / Non-Goals

**Goals:** A small coherent discovery product with secondary breed learning, predictable navigation, and non-blocking voting. English copy follows the application reference. Android release APK is the required delivery target; desktop frames describe wider layouts, not an additional platform release obligation.

**Non-Goals:** Counters of any kind, saved collections, account/login, persistent anonymous identity, encounter history, filters/preferences, matching, messaging, custom backend, guaranteed vote delivery, offline download system. Assets and detailed visual design development are outside this stage. Figma need not demonstrate interactions through a working prototype.

## Decisions

### Source of design intent

Use the Figma **Cat tinder / Application** section (33:1843), not **Main pages**, which contains earlier design-system examples and fictional profiles. Application reference frames:

| Destination | Mobile | Desktop |
|---|---|---|
| Discover | 33:2653 | 33:1844 |
| Breeds | 33:2709 | 33:1900 |
| Shared Details | 33:2757 | 33:1948 |

Retain its existing design language when implementation is later authorized. Counter components in the immutable design do not override the user's later removal of counting. Hidden Preferences content is not a feature. Missing prototype links and separate loading/error frames are intentional, not open design tasks.

### Data meaning

Discovery uses images, not uniquely identified individual animals. Images have breed associations; API votes reference images. Use the first listed breed only where one identity is required, consistently across card label and its details; preserve other associations. The catalog remains independent. No breed aggregation or vote-history retrieval is needed.

### Small navigation model

Choose two root tabs and one contextual Details destination rather than separate brief/full or cat/breed-details screens. The same information hierarchy serves both entry contexts while retaining the exact current image from Discover and selecting breed-specific content from the catalog.

### Voting without blocking discovery

The local action accepts an encounter decision; it does not claim server confirmation. Prepare the next card/image where possible and submit the vote independently. Do not add confirmation alerts, automatic retry queues, or deduplication across encounters. This prioritizes continuity over guaranteed delivery, as requested. Like and Dislike remain equally primary actions despite different visual emphasis.

## Action hierarchy and availability

| Action | Role | Availability |
|---|---|---|
| Like / right swipe | Primary | Ready, undecided Discover card only |
| Dislike / left swipe | Primary | Ready, undecided Discover card only |
| Discover / Breeds tabs | Global navigation | Every destination, including loading/error states |
| Photograph / View breed details | Secondary | Ready Discover card |
| Select breed row | Secondary | Loaded catalog |
| Read information | Secondary | Details |
| Back | Contextual navigation | Details returns to its origin |
| Retry | Recovery | Failed content operation only |
| Skip unavailable photograph | Recovery | Failed discovery photograph; no vote |

## User flows

| Journey | Path | Invariant |
|---|---|---|
| Discover and vote | Launch → Discover → card → Like/Dislike → next card | One decision per encounter; no wait for vote confirmation |
| Inspect current image | Discover photo/link → Details → Back | Same image and selected breed; no vote or advancement |
| Explore breeds | Breeds → selected row → Details → Back | Same catalog position; discovery unaffected |
| Switch activity | Any screen/state → either tab → its root | Restore retained state; no duplicate stack or late navigation |
| Recover content | Content error → Retry → content/error | Retry only failed content, never an earlier vote |
| Unavailable image | Discovery image error → Retry or skip | Retry same image; skip submits no vote |

Visible/platform Back in Details restores the origin. Platform Back from Breeds root returns to Discover; from Discover it follows normal platform exit. A Details page highlights its origin tab; selecting a tab from Details opens the root. Selecting an active root tab is a no-op.

## Acceptance and later-stage constraints

The four capability specs contain the acceptance scenarios. They cover narrow/short screens, larger text, gesture separation, asynchronous navigation, endpoint isolation, and retry. A design review establishes these paths' soundness; it does not prove running behavior. Visual asset production and prototype demonstration are not required by this review.

Later engineering must support these existing assignment constraints without deciding their implementation here:
- TheCatAPI `/v1/images/search` with `has_breeds=1`, `/v1/breeds`, and image voting; free-key access is assumed sufficient.
- Configurable `CAT_API_KEY` and `CAT_API_BASE_URL` via `--dart-define` (default base `https://api.thecatapi.com/v1`), with no committed keys, TLS bypass, or HTTPS downgrade. The base must be replaceable for evaluation.
- Typed data, network/JSON work separate from widgets, clear state ownership, safe lifecycle handling, and no unused scaffolding or unnecessary layers.
- Choose within the assignment's allowed `http`/`dio` and `Image`/`CachedNetworkImage` options later; do not add either now.
- Predeclared gates: formatting, clean Flutter analysis, release APK build, acceptance journeys/failure scenarios, and visual/accessibility review of the eventual UI. Log actual results against commits and record genuine review findings. Automated tests are optional, not a blanket requirement.
- Preserve this baseline in commit history before principal implementation when committing is authorized. No commit or push is performed by this documentation task.
- Final delivery: repository, exact commit SHA, matching GitHub Release APK, and current screenshots/video including an error state. A custom launcher icon remains a later delivery obligation; no asset decision is made here.
- Final README has eight sections: description; completed features; known issues/unimplemented requirements (including counter omission); screenshots/video; APK link; launch/check commands and results; 5–10 sentences explaining the app written by the user without AI; implementation track/AI usage with links to specs, gate log, and review.

## Risks / Trade-offs

- No like counter → deliberate assignment deviation; do not restore it silently or claim full rubric compliance.
- Best-effort votes can be lost or have uncertain outcomes → accept this product trade-off; handle failures safely and never claim confirmed delivery.
- Prefetch cannot guarantee uninterrupted browsing during content outages → bounded loading and content-specific recovery remain necessary.
- Optional source data can be absent → show Not provided rather than infer facts or introduce another content service.
- Static Figma is not runtime evidence → later verify the specified behavior in the app; do not require Figma changes or working prototype links.

## Deferred engineering stage

No unresolved product decision blocks this baseline. Engineering design, project structure, toolchain, asset production, and runtime verification are future work, not choices made by this artifact. Do not treat OpenSpec's artifact-complete status as authorization to implement or archive the product change.
