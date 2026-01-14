## 2026-01-14 - Flutter Custom Button Accessibility
**Learning:** To make custom shape buttons (like circles) accessible and interactive in Flutter, combine `Material` (for shape/color), `InkWell` (for ripple/interaction), and `Semantics` (for labels). Use `ExcludeSemantics` on adjacent text labels to avoid redundant screen reader announcements if the button's semantic label covers the intent.
**Action:** Replace `GestureDetector` with `Material > InkWell` and wrap helper text in `ExcludeSemantics` for custom action buttons.
