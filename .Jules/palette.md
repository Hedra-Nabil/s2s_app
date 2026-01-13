## 2024-05-22 - [Custom Recording Button Accessibility]
**Learning:** Custom interactive widgets built with `GestureDetector` are invisible to screen readers unless wrapped in `Semantics`. Additionally, they lack native touch feedback (ripple).
**Action:** Always wrap custom "button-like" widgets in `Semantics(button: true, label: '...')` and use `Material` + `InkWell` for visual feedback if possible, or `InkResponse`. For testing `Semantics`, finding by predicate on the `Semantics` widget type is often more reliable than `find.bySemanticsLabel` for composite widgets.
