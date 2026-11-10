# Future delivery checklist

This checklist records future work; no implementation is authorized by the current documentation request. Architecture, project structure, and toolchain must be decided in the next stage before implementation tasks are refined or executed. All unchecked items describe intended work, not completed validation.

## 1. Engineering handoff

- [ ] 1.1 Record the later engineering decisions for state ownership, data boundaries, structure, and toolchain; verify the resulting document preserves every product scenario and adds no excluded feature.
- [ ] 1.2 Establish executable quality gates for formatting, analysis, release build, and acceptance scenarios; verify their commands and evidence format are documented before principal implementation.

## 2. Discovery and voting

- [ ] 2.1 Deliver usable random cards and first-listed breed identity; verify first launch, multi-breed, empty-breed, and prepared-next-card scenarios and record results.
- [ ] 2.2 Deliver button/swipe decisions and independent positive/negative vote attempts; verify repeated input, repeated image encounters, slow/failed voting, and no counters against cat-discovery/spec.md.

## 3. Information and navigation

- [ ] 3.1 Deliver the complete catalog and shared contextual Details; verify exact-image preservation, first-listed breed consistency, optional-data fallbacks, and catalog-origin information against breed-information/spec.md.
- [ ] 3.2 Deliver global tabs and contextual return; verify retained card/list position, button-only journeys, and navigation during requests against app-navigation/spec.md.

## 4. Content recovery

- [ ] 4.1 Deliver bounded loading, content Retry, and image skip/retry; verify all content-recovery/spec.md scenarios including offline startup, mid-session loss, timeout, HTTP, malformed/empty data, and failed images, and record actual outcomes.
- [ ] 4.2 Verify cross-endpoint isolation and late-result handling with controlled failures; confirm no duplicate vote on content Retry, no forced navigation, and no unhandled lifecycle failure.

## 5. Integrated acceptance and submission

- [ ] 5.1 Run all capability scenarios on the eventual app, including 320px width, short screens, enlarged text, action labels, and required semantics; record commit-specific results and genuine review findings.
- [ ] 5.2 Run formatting, clean analysis, and release-build gates with externalized configuration; verify the resulting APK and that no secret or TLS workaround is committed.
- [ ] 5.3 Prepare the later icon/media and eight-section submission README; verify current screenshots include an error, the counter omission is disclosed, and the user supplies the architecture explanation without AI.
- [ ] 5.4 Publish only when authorized and verify the repository, submitted commit, Release tag, APK, commands, and media refer to the same version and are accessible.
