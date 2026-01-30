## 2024-05-23 - Interactive Cards and Tooltips
**Learning:** `GestureDetector` on cards lacks visual feedback. Using `Material` > `InkWell` provides standard ripple effects but requires careful handling of `borderRadius` and `clipBehavior` to match the container's decoration.
**Action:** Always wrap interactive cards in `Material(color: transparent, child: InkWell(...))` or similar structure for better touch feedback.

**Learning:** `IconButton` widgets must have a `tooltip` property for accessibility.
**Action:** Audit all `IconButton`s for missing tooltips.
