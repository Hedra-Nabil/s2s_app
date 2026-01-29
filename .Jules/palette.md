# PALETTE'S JOURNAL - CRITICAL LEARNINGS ONLY

## 2024-05-22 - Flutter Semantics and EasyLocalization Testing
**Learning:** `Semantics(excludeSemantics: true)` hides the entire subtree, including the label you are trying to add. To label a group of decorative items, just wrap them in `Semantics(label: ...)` without `excludeSemantics: true`.
**Action:** Use `Semantics(label: ..., child: ...)` to group and label decorative children.

**Learning:** Testing `EasyLocalization` in widget tests is flaky regarding asset loading. `MockAssetLoader` may be bypassed or fail to load in time.
**Action:** When testing semantics dependent on translations, write robust expectations that accept either the resolved string OR the localization key (e.g., `find.bySemanticsLabel(RegExp(r'key_name|Resolved String'))`).
