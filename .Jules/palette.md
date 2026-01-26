## 2024-05-23 - Feature Card Interaction Pattern
**Learning:** The app used `GestureDetector` on `Container` for feature cards, which lacks visual feedback (ripple) and proper accessibility focus states. `InkWell` requires a `Material` ancestor to render ripples correctly, especially with rounded corners.
**Action:** For all clickable cards in this design system, use the pattern: `Container` (layout/shadow) > `Material` (color/clip/radius) > `InkWell` (interaction) > `Padding` > `Content`. Ensure `clipBehavior: Clip.antiAlias` is set on `Material`.
