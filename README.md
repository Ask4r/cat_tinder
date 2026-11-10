# Cat tinder

A planned Flutter application for discovering cat images, sending Like/Dislike votes, and exploring breed information using TheCatAPI.

## Current status

The repository contains the Flutter starter and an active OpenSpec baseline. Product behavior, project structure, and the principal toolchain are agreed; application features and integration checks are not implemented or verified by this documentation update.

## Specifications and decisions

- [Scope and assignment deviation](openspec/changes/define-product-baseline/proposal.md)
- [User flows, ownership, structure, toolchain, and remaining decisions](openspec/changes/define-product-baseline/design.md)
- [Discovery and voting](openspec/changes/define-product-baseline/specs/cat-discovery/spec.md)
- [Breed information](openspec/changes/define-product-baseline/specs/breed-information/spec.md)
- [Navigation](openspec/changes/define-product-baseline/specs/app-navigation/spec.md)
- [Content recovery](openspec/changes/define-product-baseline/specs/content-recovery/spec.md)
- [Project-structure quality gates](openspec/changes/define-product-baseline/structure-gates.md)
- [Future implementation and delivery checklist](openspec/changes/define-product-baseline/tasks.md)

The selected stack is Flutter, Cached Query for remote query lifecycle, Riverpod for application state, Dio for HTTP, and Navigator for navigation. There is no DI layer. These selections do not mean dependencies are already installed; use latest stable compatible releases when implementation is authorized.

Like counting is deliberately excluded in every form despite the assignment's counter requirement. Voting still proceeds independently of immediate discovery advancement. This is a known coursework deviation.

## References

- [Assignment](https://georgfed.github.io/hse-flutter-course/assignments/hw1.html)
- [Figma Application section](https://www.figma.com/design/acHPvZOOHJwYz12WXSZRQa/Cat-tinder?node-id=33-1843)
- [TheCatAPI reference](https://docs.thecatapi.com/reference)

Release instructions, verified commands/results, screenshots, APK links, and the user-authored explanation remain delivery work. This planning README does not claim a completed submission. Documentation reconciled on 2026-11-11; source, dependencies, and design files were not changed.
