## 2024-05-23 - Custom Button Accessibility
**Learning:** For custom buttons (like the recording circle), use `Semantics` -> `Material` -> `InkWell` structure. This provides both the accessibility label (via Semantics) and the visual ripple feedback (via Material+InkWell), which is missing in simple `GestureDetector` implementations.
**Action:** When refactoring custom touch targets, always look for `GestureDetector` and consider upgrading to `InkWell` with explicit `Semantics`.
