# Future delivery checklist

This checklist records future work; no implementation is authorized by the current documentation request. The selected structure and toolchain are recorded in design.md; integration details will be resolved within feature implementation, and standard Flutter checks will be used during implementation without a separate setup stage. There is no separate query proof or preliminary query experiment. All unchecked items describe intended work, not completed validation.

## 1. Engineering handoff

- [x] 1.1 Reconcile the selected ownership boundaries, structure, toolchain, and shared detail UI with the product baseline (documentation only; 2026-11-11).
- [ ] 1.2 Use the standard Flutter formatting, analysis, and release-build checks during implementation and record actual commands/results alongside relevant acceptance evidence; no custom gate-setup stage.
- Superseded 1.3: the standalone query-integration proof is omitted by decision on 2026-11-11. Integration work and checks belong to discovery implementation (2.3), not a prerequisite stage.
- [ ] 1.4 Resolve stable compatible dependency versions, choose image loading/cache handling, and tune refill/preload parameters; record concrete exceptions only if discovered.
- [x] 1.5 Define project-structure gates, dependency boundaries, semantic review criteria, and evidence policy in structure-gates.md (documentation only; 2026-11-11).
- [ ] 1.6 Apply G1–G8 through code review, without automated structure/architecture linters or validators; resolve the G5 callback/state dependency boundary before accepting its integration.

## 2. Discovery and voting

- [ ] 2.1 Deliver the shared append-only refill queue, usable random cards, and first-listed breed identity; verify first launch, multi-breed, empty-breed, preloaded-next-card, overlapping refill, and once-per-execution append scenarios and record results.
- [ ] 2.2 Deliver button/swipe decisions and independent positive/negative vote attempts; verify repeated input, repeated image encounters, slow/failed voting, and no counters against cat-discovery/spec.md.

- [ ] 2.3 As part of the discovery flow, implement centralized Cached Query/Dio callbacks with Riverpod state and settle cancellation, sharing, query keys, retry/refetch, and once-per-execution result consumption. Apply G5–G6 to the actual feature; no separate proof deliverable or widget-level lifecycle boilerplate.

## 3. Information and navigation

- [ ] 3.1 Deliver the complete catalog and contextual detail pages sharing the full information UI; verify exact-image preservation, first-listed breed consistency, optional-data fallbacks, and catalog-origin information against breed-information/spec.md.
- [ ] 3.2 Deliver global tabs and contextual return; verify retained card/list position, button-only journeys, and navigation during requests against app-navigation/spec.md.

## 4. Content recovery

- [ ] 4.1 Deliver bounded loading, content Retry, and image skip/retry; verify all content-recovery/spec.md scenarios including buffered refill failure and exhaustion, offline startup, mid-session loss, timeout, HTTP, malformed/empty data, and failed images, and record actual outcomes.
- [ ] 4.2 Verify cross-endpoint isolation and late-result handling with controlled failures; confirm no duplicate vote on content Retry, no forced navigation, and no unhandled lifecycle failure.

## 5. Integrated acceptance and submission

- [ ] 5.1 Run all capability scenarios on the eventual app, including 320px width, short screens, enlarged text, action labels, and required semantics; record commit-specific results and genuine review findings.
- [ ] 5.2 Run formatting, clean analysis, and release-build gates with externalized configuration; verify the resulting APK and that no secret or TLS workaround is committed.
- [ ] 5.3 Prepare the later icon/media and eight-section submission README; verify current screenshots include an error, the counter omission is disclosed, and the user supplies the architecture explanation without AI.
- [ ] 5.4 Publish only when authorized and verify the repository, submitted commit, Release tag, APK, commands, and media refer to the same version and are accessible.
