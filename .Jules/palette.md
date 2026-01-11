# Palette's Journal

## 2024-05-22 - Custom Button Accessibility
**Learning:** `GestureDetector` on custom shapes (like the circular recording button) lacks semantic information and touch feedback (ripple), making it inaccessible and less intuitive.
**Action:** Use `Semantics` > `Material` > `InkWell` (with `customBorder: CircleBorder()`) for custom circular buttons to provide both accessibility labels and visual touch feedback.
