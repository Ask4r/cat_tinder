# Cat tinder product baseline

## Why

Record the agreed product behavior before implementation so the assignment, Figma references, and evolving conversation have one reviewable baseline. This change is planning only: the existing Flutter scaffold is not evidence that these behaviors are implemented.

## What Changes

- Define Discover, Breeds, and contextual detail pages sharing the same information UI, with primary, secondary, global, and recovery actions.
- Define immediate discovery progression with independent positive/negative API vote submission.
- Define first-listed breed selection only where an image needs one breed identity; retain other associations.
- Define recoverable content failures and session continuity without making vote delivery block discovery.
- Explicitly exclude like counting in every form, superseding all earlier image-level, breed-level, user-level, and session-counter proposals.
- Record product acceptance checks, the selected project structure and toolchain, and remaining integration/release obligations.

## Capabilities

### New Capabilities

- `cat-discovery`: Random image cards, gesture/button decisions, and non-blocking voting. [Specification](specs/cat-discovery/spec.md)
- `breed-information`: Breed catalog, contextual details, and truthful source-data presentation. [Specification](specs/breed-information/spec.md)
- `app-navigation`: Global navigation, contextual return paths, and session continuity. [Specification](specs/app-navigation/spec.md)
- `content-recovery`: Bounded loading and scoped recovery from unavailable content. [Specification](specs/content-recovery/spec.md)

### Modified Capabilities

None. The main OpenSpec capability inventory is empty.

## Impact

This change reconciles planning artifacts and the project documentation entry point; it does not authorize implementation. Application source, dependencies, assets, Figma files, and existing project configuration remain unchanged. The intended application uses TheCatAPI image search, breeds, and votes; free API-key availability is assumed. No custom backend, account/login, saved collection, user identity system, preferences, or persistent vote queue is required.

The assignment requires a visible increasing like counter and `like_counter` semantics. The user's final decision excludes counting entirely: this is an intentional coursework deviation, not a claim of full assignment compliance. It remains an external grading risk, not an unresolved product choice.

References:
- [Assignment](https://georgfed.github.io/hse-flutter-course/assignments/hw1.html)
- [Application design](https://www.figma.com/design/acHPvZOOHJwYz12WXSZRQa/Cat-tinder?node-id=33-1843)
- [API reference](https://docs.thecatapi.com/reference)
- [User flows and scope decisions](design.md)

Baseline initially recorded on 2026-11-10 and reconciled on 2026-11-11 with the settled engineering decisions and latest design review. Implementation requires a separate authorization; artifact completeness does not authorize implementation.
