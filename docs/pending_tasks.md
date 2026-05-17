# Pending Tasks

## High priority

- Fix Receiver success navigation returning to Home Driver.
- Review the role-based home resolver used after success flows.
- Confirm DTO compatibility with the Django receiving response.
- Review route lifecycle status transitions.
- Validate pickup and receiving temperature fields across the full flow.

## Agent support and localization

- Keep `.agent/` guidance aligned with the real repository structure.
- Use `mobile/lib/core/l10n/app_strings.dart` as the canonical Flutter strings file.
- Preserve `lib/core/l10n/app_strings.dart` as an agent-compatibility path when needed.
- Replace hardcoded English UI strings with centralized Portuguese strings.
- Prioritize login, Driver flow, Receiver flow and success and error messages.

## Medium priority

- Improve error messages in the receiving flow.
- Add loading states to API actions.
- Add empty states for pending routes.
- Add a route summary screen if the current implementation still lacks one.

## Low priority

- Improve UI consistency.
- Add dashboard cards.
- Add report export.
