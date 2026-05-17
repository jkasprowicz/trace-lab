# Review Checklist

Before considering a task complete, verify:

## Flutter

- Does `flutter analyze` pass?
- Does the app compile?
- Is navigation role-correct?
- Are Driver and Receiver flows separated?
- Are DTO field names compatible with API response?
- Are null values handled safely?
- Is state updated after success/error?
- Are all user-facing strings in Brazilian Portuguese?

## Django

- Does `python manage.py check` pass?
- Are serializers compatible with frontend DTOs?
- Are permissions appropriate for role access?
- Are migrations needed?
- Are timestamps preserved?

## Domain

- Is temperature traceability preserved?
- Is route ID preserved?
- Is responsible user preserved?
- Is receiving distinct from pickup?
- Does success navigation return to the correct role home?

## Output

The agent should explicitly report:

- what changed
- why it changed
- what was not changed
- how to test manually