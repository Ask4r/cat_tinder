# Feature-focused development plan

Implement these feature slices in order. The user authorized slice 1, now implemented; Settings appearance selection and retained root-tab navigation were also explicitly authorized and are implemented. The remaining slices record future work and require further authorization. All unchecked items are pending. The discovery slice is implemented; verification and remaining environment limits are recorded in [discovery-implementation.md](discovery-implementation.md). The product baseline, selected structure/toolchain, and review gates have been documented. The current Widgetbook scope is complete; the next planned feature is discovery-origin details (slice 2).

Navigation, recovery, dependency choices, and relevant validation belong within each feature. They are not separate setup stages. Discovery query integration is implemented; extend it within the remaining feature slices without a standalone query proof. Apply [structure-gates.md](structure-gates.md) through review only, without automated structure/architecture linters or validators. Use standard Flutter checks and record applicable acceptance evidence throughout, rather than adding validation as a separate step after every task.

## 1. Cat discovery

- [x] 1.1 Show the current cat photograph and first-listed breed using the shared image queue, background append-only refill, and photograph preloading. Establish the Cached Query–Dio–Riverpod integration here, including centralized callbacks, safe cancellation/reuse, shared requests, and once-per-execution refill consumption. Choose image loading/cache handling and initial refill/preload settings within this feature.
- [x] 1.2 Support Like/Dislike through buttons and swipes, advancing immediately while independently attempting the image vote. Accept one decision per encounter, permit repeated images, and retain no discovery history or counters.
- [x] 1.3 Include bounded initial loading, exhausted-queue recovery, and same-photograph retry/skip without voting. Keep background refill failures unobtrusive while usable cards remain; isolate vote failures from content recovery and keep refill retryable.

Acceptance follows [cat-discovery](specs/cat-discovery/spec.md) and the applicable [content-recovery](specs/content-recovery/spec.md) scenarios, including overlapping input/refill, cached-result replay, empty or unusable records, and slow/failed votes. The callback/state dependency boundary is implemented and reviewed under G5–G6; preserve it when extending discovery.

## Completed component-catalog scope

- [x] Set up Widgetbook and Alchemist with the selected grouped light/dark sheets, button interaction captures, and manual playgrounds. Catalog organization and coverage review are complete for this stage; see the [catalog instructions](../../../widgetbook/README.md) for the retained scope and intentional exclusions.

This milestone does not require standalone stories or screenshots for every widget. The incomplete select popup remains unfinished and excluded from the catalog; completing it or expanding catalog coverage requires a separate scope decision.

## 2. Discovery-origin details

- [ ] 2.1 Open full breed information from the ready card photograph or link, preserving the exact discovery image and selected breed without consuming the queue head.
- [ ] 2.2 Build reusable detail-content widgets with available fuller information, truthful missing-data presentation, and partial-content/image recovery. Confirm handwritten DTO fields against actual API data; never invent missing facts or treat unknown flags as No.
- [ ] 2.3 Return to the same undecided discovery card through visible or platform Back, with the Discover context retained and no vote or automatic advancement.

Acceptance follows [breed-information](specs/breed-information/spec.md), [app-navigation](specs/app-navigation/spec.md), and scoped recovery requirements. Separate contextual pages are permitted; sharing the full detail UI does not require one page class or route.

## 3. Breed catalog and catalog-origin details

- [ ] 3.1 Display the complete alphabetical breed catalog with its loading/recovery states and open the selected breed from its row.
- [ ] 3.2 Reuse the full detail-content widgets with the selected breed and its representative photograph, allowing readable information when no photograph is available. Preserve catalog position on return and leave discovery unaffected.
- [ ] 3.3 Integrate the Breeds root and both detail contexts with the existing Discover/Breeds/Settings shell and tab history, including loading and error states. Preserve discovery/catalog state, highlight the originating tab in details, and implement contextual Back without duplicate stacks or late-result navigation.

Root-tab switching, browser Back/Forward and platform Back between the implemented Discover and Settings roots are complete. Task 3.3 covers their extension to Breeds and the still-pending contextual details navigation; it does not require reimplementing the existing root-history mechanism.

Acceptance follows the catalog, contextual navigation, and session-continuity scenarios. All journeys remain available without swipes; global navigation is part of the completed features, not deferred to release polish.

## 4. Application-wide usability

The previous per-issue Flutter UI suites have been removed. The selected Widgetbook/Alchemist scope is complete as recorded above. Page-flow automation is outside that scope; it is not an additional catalog-completion requirement. Full-flow usability and platform acceptance below remain pending and require their own evidence; component screenshots do not satisfy them.

- [ ] 4.1 Refine the complete flows against the Figma Application reference on narrow (including 320 logical pixels), short, and wider screens. Address enlarged text, accessibility labels and required semantics, touch targets, scrolling, long content, and gesture conflicts.
- [ ] 4.2 Exercise cross-feature situations: rapid navigation, background/resume, slow requests, connection loss, endpoint outages, malformed/empty responses, and failed photographs. Resolve stale state writes, unintended repeated requests, lifecycle failures, or lost session continuity while preserving scoped recovery and nonblocking votes.

Use the complete capability scenarios and record results against the reviewed version, along with genuine review findings. This stage integrates and refines feature behavior; it does not postpone ordinary correctness checks from earlier slices.

## 5. Delivery

Platform branding is implemented: launcher/favicon assets, visible app names, descriptions, web manifest and startup branding. Asset generation uses `icons_launcher` and `flutter_native_splash`, with existing platform policies and first-frame timing preserved. See [branding sources and regeneration](../../../assets/branding/README.md). This completes the icon/metadata portion of 5.1 only; release APK acceptance, media, signing/identity review and publication remain pending.

- [ ] 5.1 Prepare the release APK and current screenshots/video including a recovery state, retaining the implemented launcher branding. Use externalized API configuration and standard formatting, clean analysis, and release-build checks; record actual commands/results and verify the resulting APK without committing secrets or TLS workarounds.
- [ ] 5.2 Complete the eight-section submission README described in design.md, disclose the deliberate counter omission, link specifications and verification/review evidence, and obtain the user's own 5–10 sentence explanation without AI authorship.
- [ ] 5.3 Publish only when authorized. Verify the repository, exact submitted commit, GitHub Release tag/APK, commands, and media refer to the same version and are accessible.

Commit, push and publication require authorization. Completion of the catalog milestone does not mark the remaining feature or delivery tasks complete.
