## 2024-05-23 - [EasyLocalization Testing Strategy]
**Learning:** `EasyLocalization` in widget tests is tricky to mock correctly, often failing to load assets even with a mock loader, resulting in keys being displayed.
**Action:** When testing widgets with `EasyLocalization`, implement a fallback strategy in `find.text()` to check for either the translated value OR the key, to ensure tests are robust against localization loading timing issues.
