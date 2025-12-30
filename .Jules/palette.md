## 2024-05-23 - [Recording Button Accessibility]
**Learning:** `GestureDetector` on simple Containers is a common pattern for custom buttons but completely fails accessibility. Replacing with `Semantics` + `Material` + `InkWell` (with `customBorder`) provides both a11y (label, button role) and better UX (ripple effect, keyboard focus) while maintaining the exact custom look.
**Action:** When seeing `GestureDetector` used for primary actions, immediately check for `Semantics` wrapping. If missing, refactor to `InkWell` or `IconButton` if possible, or wrap in `Semantics` at minimum.
