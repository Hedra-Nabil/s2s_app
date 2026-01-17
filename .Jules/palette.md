## 2024-05-22 - Custom Button Accessibility & Interaction
**Learning:** Custom buttons built with `GestureDetector` lack standard accessibility traits and visual feedback (ripples). Wrapping them in `Semantics` > `Material` > `InkWell` provides both accessible labels/traits and standard Material interaction feedback.
**Action:** When creating custom buttons, ensure they are wrapped in `Semantics` (with `button: true`) and use `InkWell` for interaction.

## 2024-05-22 - Avoiding Redundant Labels
**Learning:** When a button has a clear semantic label (e.g., "Start recording"), adjacent explanatory text (e.g., "Tap to start recording") becomes redundant and noisy for screen reader users.
**Action:** Use `ExcludeSemantics` on helper text when the primary action is already clearly labeled via `Semantics` or `tooltip`.
