# Feature-focused development plan

Implement these feature slices in order. This plan records future work and does not authorize implementation. All unchecked items are pending; the existing Flutter scaffold is not evidence of feature completion. The product baseline, selected structure/toolchain, and review gates have been documented.

Navigation, recovery, dependency choices, and relevant validation belong within each feature. They are not separate setup stages. Resolve query integration while implementing discovery; no standalone query proof is required. Apply [structure-gates.md](structure-gates.md) through review only, without automated structure/architecture linters or validators. Use standard Flutter checks and record applicable acceptance evidence throughout, rather than adding validation as a separate step after every task.

## 1. Cat discovery

- [ ] 1.1 Show the current cat photograph and first-listed breed using the shared image queue, background append-only refill, and photograph preloading. Establish the Cached Query–Dio–Riverpod integration here, including centralized callbacks, safe cancellation/reuse, shared requests, and once-per-execution refill consumption. Choose image loading/cache handling and initial refill/preload settings within this feature.
- [ ] 1.2 Support Like/Dislike through buttons and swipes, advancing immediately while independently attempting the image vote. Accept one decision per encounter, permit repeated images, and retain no discovery history or counters.
- [ ] 1.3 Include bounded initial loading, exhausted-queue recovery, and same-photograph retry/skip without voting. Keep background refill failures unobtrusive while usable cards remain; isolate vote failures from content recovery and keep refill retryable.

Acceptance follows [cat-discovery](specs/cat-discovery/spec.md) and the applicable [content-recovery](specs/content-recovery/spec.md) scenarios, including overlapping input/refill, cached-result replay, empty or unusable records, and slow/failed votes. Settle the callback/state dependency boundary as part of this implementation and review it under G5–G6.

## 2. Discovery-origin details

- [ ] 2.1 Open full breed information from the ready card photograph or link, preserving the exact discovery image and selected breed without consuming the queue head.
- [ ] 2.2 Build reusable detail-content widgets with available fuller information, truthful missing-data presentation, and partial-content/image recovery. Confirm handwritten DTO fields against actual API data; never invent missing facts or treat unknown flags as No.
- [ ] 2.3 Return to the same undecided discovery card through visible or platform Back, with the Discover context retained and no vote or automatic advancement.

Acceptance follows [breed-information](specs/breed-information/spec.md), [app-navigation](specs/app-navigation/spec.md), and scoped recovery requirements. Separate contextual pages are permitted; sharing the full detail UI does not require one page class or route.

## 3. Breed catalog and catalog-origin details

- [ ] 3.1 Display the complete alphabetical breed catalog with its loading/recovery states and open the selected breed from its row.
- [ ] 3.2 Reuse the full detail-content widgets with the selected breed and its representative photograph, allowing readable information when no photograph is available. Preserve catalog position on return and leave discovery unaffected.
- [ ] 3.3 Complete global Discover/Breeds navigation across both detail contexts, loading, and error states. Preserve discovery and catalog session state, highlight the originating tab in details, and implement the agreed root and contextual Back behavior without duplicate stacks or late-result navigation.

Acceptance follows the catalog, contextual navigation, and session-continuity scenarios. All journeys remain available without swipes; global navigation is part of the completed features, not deferred to release polish.

## 4. Application-wide usability

- [ ] 4.1 Refine the complete flows against the Figma Application reference on narrow (including 320 logical pixels), short, and wider screens. Address enlarged text, accessibility labels and required semantics, touch targets, scrolling, long content, and gesture conflicts.
- [ ] 4.2 Exercise cross-feature situations: rapid navigation, background/resume, slow requests, connection loss, endpoint outages, malformed/empty responses, and failed photographs. Resolve stale state writes, unintended repeated requests, lifecycle failures, or lost session continuity while preserving scoped recovery and nonblocking votes.

Use the complete capability scenarios and record results against the reviewed version, along with genuine review findings. This stage integrates and refines feature behavior; it does not postpone ordinary correctness checks from earlier slices.

## 5. Delivery

- [ ] 5.1 Prepare the launcher icon, release APK, and current screenshots/video including a recovery state. Use externalized API configuration and standard formatting, clean analysis, and release-build checks; record actual commands/results and verify the resulting APK without committing secrets or TLS workarounds.
- [ ] 5.2 Complete the eight-section submission README described in design.md, disclose the deliberate counter omission, link specifications and verification/review evidence, and obtain the user's own 5–10 sentence explanation without AI authorship.
- [ ] 5.3 Publish only when authorized. Verify the repository, exact submitted commit, GitHub Release tag/APK, commands, and media refer to the same version and are accessible.

Preserve the baseline in commit history before principal implementation when committing is authorized. This documentation task performs no commit, push, source change, or publication.
