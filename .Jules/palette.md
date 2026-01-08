## 2024-05-22 - Accessibility of Custom Buttons and IconButtons
**Learning:** Custom buttons built with `GestureDetector` lack accessibility semantics (label, role) and visual feedback (focus, ripple). `IconButton`s without tooltips are inaccessible to screen readers and lack hover information.
**Action:** Always wrap custom interactive elements in `Semantics` (providing label, button role) and use `InkWell` + `Material` for visual feedback. Always populate the `tooltip` property on `IconButton`.
