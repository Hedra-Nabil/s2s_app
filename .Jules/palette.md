## 2026-02-05 - [Password Visibility UX]
**Learning:** `TextField` widgets with `obscureText: true` (passwords) lack a visibility toggle by default in this codebase, increasing user error rates.
**Action:** Always implement a visibility toggle for password fields using a `suffixIcon` with `IconButton`, managing state locally, and ensure proper accessibility tooltips ("Show password"/"Hide password") are used.
