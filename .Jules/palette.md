## 2024-05-21 - Interactive Card Accessibility
**Learning:** Using `GestureDetector` on custom cards prevents ripple effects and can hinder accessibility focus states. Replacing it with `Material` > `InkWell` provides immediate visual feedback and better accessibility traits.
**Action:** When making custom cards interactive, always wrap the content in `Material` (with appropriate `borderRadius`) and use `InkWell` instead of `GestureDetector`.
