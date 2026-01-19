## 2024-05-23 - Accessibility in Flutter
**Learning:** `NetworkImage` in Flutter widget tests requires robust `HttpOverrides` mocking, otherwise it throws exceptions or attempts network connections.
**Action:** Always include a `TestHttpOverrides` class in widget tests that use `NetworkImage`, implementing a dummy `HttpClient` that returns a safe response (e.g., 404 or empty image) to prevent test flakiness.
