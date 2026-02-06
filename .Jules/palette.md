## 2023-10-27 - [Material InkWell Ripple and Shadow Clipping]
**Learning:** Wrapping a `Container` with `decoration` (specifically `color`) inside an `InkWell` prevents the ripple effect from showing because the container paints over the ripple.
**Action:** Use a `Material` widget as the parent of `InkWell`. Apply the `color` and `borderRadius` to the `Material` widget, and `clipBehavior: Clip.hardEdge` to ensure the ripple respects the corners. If a shadow is needed, wrap the `Material` in a `Container` that handles the shadow (with transparent color).
