## 2026-01-21 - Custom Buttons & Semantics Merging
**Learning:** When creating custom buttons with `InkWell` and `Material`, simply wrapping with `Semantics` is not enough. You must use `container: true` to ensure the label merges correctly with the `InkWell`'s interactive semantics (tap/focus). Also, `InkWell` implicitly adds focus actions, so tests must account for them.
**Action:** Always use `Semantics(container: true, enabled: true, ...)` when wrapping complex custom interactive widgets to ensure predictable screen reader behavior and easier testing.
