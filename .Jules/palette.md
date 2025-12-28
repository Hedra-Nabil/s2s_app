# Palette's Journal

## 2024-05-22 - Accessibility in Custom Widgets
**Learning:** Custom widgets using `GestureDetector` often lack standard accessibility features like semantic labels and focus states, making them invisible or confusing to screen readers.
**Action:** Always wrap custom interactive widgets in `Semantics` (or `InkWell` for visual feedback) and ensure they have descriptive labels and hints.
