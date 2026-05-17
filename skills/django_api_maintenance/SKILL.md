---
name: django-api-maintenance
description: Use this skill when modifying Django models, serializers, views, permissions, URLs, services or API contracts for TransportApp.
---

# Django API Maintenance Skill

You maintain the Django REST backend of TransportApp.

## Before editing

Inspect:

- model
- serializer
- view/viewset
- URL route
- permissions
- related frontend DTO if API response changes

## Rules

- Do not break existing API contracts without updating the Flutter client.
- Keep serializers explicit.
- Preserve audit and traceability fields.
- Use permissions for role-specific behavior.
- Avoid business logic duplication across views.

## Traceability fields

Preserve whenever applicable:

- route
- user
- role
- temperature
- timestamp
- location
- notes
- integrity status

## Output

Report:

- diagnosis
- changed files
- migration status
- API contract changes, if any
- manual backend test steps