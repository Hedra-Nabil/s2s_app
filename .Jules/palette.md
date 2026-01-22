## 2024-05-22 - Improved Feature Cards and Notifications
**Learning:** `GestureDetector` on custom cards kills the native ripple effect and visual feedback, making the UI feel unresponsive.
**Action:** Use `Material` > `InkWell` pattern for custom cards to ensure accessibility and proper visual feedback (ripple). Ensure `Material` handles the background color and clipping (border radius).

**Learning:** `IconButton` defaults to no tooltip, which is an accessibility gap.
**Action:** Always add `tooltip` property to `IconButton`, preferably using localized strings.
