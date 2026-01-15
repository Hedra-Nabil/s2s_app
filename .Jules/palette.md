## 2026-01-15 - Accessibility on Custom Buttons in Flutter
**Learning:** Custom buttons constructed with `GestureDetector` or `InkWell` often lack semantic information. Wrapping them in `Semantics` with `container: true` is necessary to ensure the label and button trait are correctly merged and exposed to screen readers and test finders.
**Action:** When creating custom buttons, always wrap the widget tree in `Semantics(container: true, button: true, label: 'Action Name', child: ...)` to guarantee accessibility.
