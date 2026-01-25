# Palette's Journal

## 2023-10-27 - Improving Feature Card Interactions
**Learning:** `GestureDetector` on cards provides no visual feedback, making the UI feel unresponsive. Replacing it with `InkWell` requires careful widget composition (Material > InkWell > Container) to preserve decoration while showing the ripple.
**Action:** Always prefer `InkWell` or `TextButton` over `GestureDetector` for primary interactive elements to ensure accessibility (focus, keyboard) and feedback (ripple).
