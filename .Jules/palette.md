## 2024-05-23 - [Interactive Card Ripple Pattern]
**Learning:** To add ripple effects to custom `Container`-based cards with shadows without clipping the shadow, use a transparent `Material` widget inside the Container, and set `borderRadius` on the `InkWell` to match the Container's border radius.
**Action:** Use this pattern when refactoring other `GestureDetector` cards (like in `SignToVoiceScreen`).
