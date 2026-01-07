## 2024-05-23 - Accessibility for Custom Buttons in Flutter
**Learning:** Custom interactive elements built with `GestureDetector` (like the recording button) are invisible to screen readers and lack visual feedback (ripples), creating a poor experience for assistive technology users.
**Action:** Always wrap custom interactive widgets in a `Semantics` widget (defining `button: true`, `label`, etc.) and use `InkWell` + `Material` (with `customBorder` for shapes) to ensure both semantic availability and native visual feedback.
