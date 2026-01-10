# Palette's Journal

## 2024-05-22 - Flutter Semantics
**Learning:** In Flutter, `IconButton` requires a `tooltip` to satisfy accessibility requirements, acting as the ARIA label.
**Action:** Always ensure `IconButton` widgets have a meaningful `tooltip` property.

## 2024-05-22 - Custom Button Accessibility
**Learning:** `GestureDetector` on its own does not provide semantic information or visual feedback (ripple).
**Action:** Use `Semantics` > `Material` > `InkWell` for custom buttons to ensure accessibility and proper visual feedback.
