## 2024-05-23 - Accessibility of Custom Record Button
**Learning:** Custom interactive elements (like `GestureDetector` wrapped `Container`s) are invisible to screen readers by default. Wrapping them in `Semantics` and using `InkWell` inside `Material` provides both accessibility labels and visual touch feedback (ripples), significantly improving the experience for all users.
**Action:** Always prefer `InkWell` + `Semantics` over bare `GestureDetector` for primary actions. Use `customBorder` on `InkWell` to match non-rectangular shapes.
