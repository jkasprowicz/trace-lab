# Review Checklist

Before considering a task complete, verify:

## Flutter

- Does `flutter analyze` pass in `mobile/`?
- Do the changed screens or widgets compile?
- Is navigation role-correct?
- Are Driver and Receiver flows still separated?
- Are DTO field names compatible with the API response?
- Are null values handled safely?
- Is state updated after success and error states?
- Are all user-facing strings in Brazilian Portuguese?

## Django

- Does `python manage.py check` pass in `backend/`?
- Are serializers compatible with frontend DTOs?
- Are permissions appropriate for role access?
- Are migrations needed?
- Are timestamps preserved?

## Domain

- Is temperature traceability preserved?
- Is route ID preserved?
- Is the responsible user preserved?
- Is receiving distinct from pickup?
- Does success navigation return to the correct role home?

## Output

The agent should explicitly report:

- what changed
- why it changed
- what was not changed
- how to test manually
