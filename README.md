# Cat tinder

A Flutter application under development for discovering cat images, sending Like/Dislike votes, and exploring breed information using TheCatAPI.

## Current status

The first development slice implements discovery: a prefetched image queue, Like/Dislike buttons and swipes, independent vote submission, and content/image recovery. Settings supports persisted Light/Dark/System appearance; root tabs retain views and scroll positions, crossfade, and participate in browser/platform history. Breed browsing and detail entry are visibly disabled until their planned feature slices are implemented. No counters are included.

See [implementation decisions and verification evidence](openspec/changes/define-product-baseline/discovery-implementation.md).

## Specifications and decisions

- [Scope and assignment deviation](openspec/changes/define-product-baseline/proposal.md)
- [User flows, ownership, structure, toolchain, and remaining decisions](openspec/changes/define-product-baseline/design.md)
- [Discovery and voting](openspec/changes/define-product-baseline/specs/cat-discovery/spec.md)
- [Breed information](openspec/changes/define-product-baseline/specs/breed-information/spec.md)
- [Navigation](openspec/changes/define-product-baseline/specs/app-navigation/spec.md)
- [Content recovery](openspec/changes/define-product-baseline/specs/content-recovery/spec.md)
- [Project-structure quality gates](openspec/changes/define-product-baseline/structure-gates.md)
- [Feature-focused development plan](openspec/changes/define-product-baseline/tasks.md)

The selected stack is Flutter, Cached Query for remote query lifecycle, Riverpod for application state, Dio for HTTP, and Navigator for navigation. There is no DI layer. The selected dependencies are resolved in pubspec.lock.

Like counting is deliberately excluded in every form despite the assignment's counter requirement. Voting still proceeds independently of immediate discovery advancement. This is a known coursework deviation.

## References

- [Assignment](https://georgfed.github.io/hse-flutter-course/assignments/hw1.html)
- [Figma Application section](https://www.figma.com/design/acHPvZOOHJwYz12WXSZRQa/Cat-tinder?node-id=33-1843)
- [TheCatAPI reference](https://docs.thecatapi.com/reference)

Release instructions, verified commands/results, screenshots, APK links, and the user-authored explanation remain delivery work. This planning README does not claim a completed submission. The recent layout extraction and documentation reconciliations did not modify Figma files.

## Run discovery

Copy the configuration template, then fill in `CAT_API_KEY` in your local `config.json`:

```sh
cp config.example.json config.json
# Edit config.json, then run:
flutter run --dart-define-from-file=config.json
```

Both configuration values are supplied at build time through `--dart-define-from-file` and read with `String.fromEnvironment`. The example supplies the service URL; application code has no fallback URL or API key. The service URL must use HTTPS. Without configuration, the app shows a configuration recovery state. `config.json` is ignored by Git and is not bundled as an asset, but compiled values are still recoverable from the application. Configuration changes require rebuilding/restarting with the flag; hot reload does not update them.

An existing local `.env` is no longer read. Use `config.json` for subsequent runs.

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze --fatal-infos --fatal-warnings
flutter test --dart-define-from-file=config.test.json
flutter build apk --release --dart-define-from-file=config.json
```

An Android SDK is required for the APK build. The implementation evidence distinguishes successful checks from unavailable build/live-service verification.

Web photographs use Flutter’s HTML image loading strategy so CDN images can display without CORS permission for byte access. API calls still use Dio. Browser rendering requires manual verification; the earlier browser regression and its fixture were removed with the UI suites.

## Test scope

The automated suite covers rejection of missing API configuration, discovery queue/query/vote/recovery behavior and appearance persistence. Run `flutter test --dart-define-from-file=config.test.json` without service dart-defines; the configuration test deliberately verifies the unconfigured build, not valid configuration parsing. The former per-issue UI suites were removed. [Widgetbook and Alchemist](widgetbook/README.md) now cover grouped AppButton variants in light/dark and native hover/focus on medium defaults; other component families and page flows remain pending. Use manual UI/browser/device checks where relevant. Prefer a small set of meaningful contracts over one regression test per past issue; extend existing coverage instead of duplicating narrower scenarios.

Run the catalog with `flutter run -d chrome --target widgetbook/main.dart`. Run application-contract tests with `flutter test --dart-define-from-file=config.test.json --exclude-tags visual`, and macOS screenshots with `flutter test --dart-define-from-file=config.test.json test/visual`. The default `flutter test --dart-define-from-file=config.test.json` runs both on macOS. No API configuration is needed for the catalog.
