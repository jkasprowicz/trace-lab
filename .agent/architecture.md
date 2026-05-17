# Architecture

## Repository layout

```text
.
├── .agent/
├── backend/
│   ├── accounts/
│   ├── config/
│   ├── core/
│   ├── routes_app/
│   └── manage.py
├── docs/
├── mobile/
│   ├── lib/
│   │   ├── app/
│   │   ├── core/
│   │   │   ├── config/
│   │   │   ├── l10n/
│   │   │   ├── network/
│   │   │   ├── theme/
│   │   │   └── widgets/
│   │   └── features/
│   └── test/
└── skills/
```

## Frontend

The Flutter app lives in `mobile/`.

Conventions currently in use:

- Feature-based organization under `mobile/lib/features/`.
- Screens in `presentation/screens`.
- Reusable widgets in `presentation/widgets`.
- DTOs in `data/dto` when the feature uses DTOs.
- API services in `data/services`.
- Domain models in `domain/models`.
- App-wide strings in `mobile/lib/core/l10n/app_strings.dart`.
- Shared app routing in `mobile/lib/app/routes.dart`.

Maintenance guidance:

- Preserve existing feature boundaries.
- Keep role-based navigation explicit.
- Avoid putting API parsing or domain rules directly inside widgets.

## Backend

The Django app lives in `backend/`.

Current structure highlights:

- `backend/config/`: project configuration.
- `backend/accounts/`: authentication and account-related behavior.
- `backend/routes_app/`: route and transport-related backend logic.
- `backend/core/`: shared backend components.

Maintenance guidance:

- Keep models, serializers and views aligned.
- Do not change API contracts without checking the Flutter client.
- Keep permissions and role separation explicit.
- Preserve audit and traceability fields in transport flows.
