# Architecture

## Frontend

The Flutter app should use feature-based organization.

Recommended pattern:

```text
lib/
├── core/
│   ├── routing/
│   ├── theme/
│   ├── auth/
│   ├── networking/
│   └── l10n/
├── features/
│   ├── driver/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── receiving/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── routes/
│   ├── auth/
│   └── admin/
└── main.dart
```

## Flutter conventions

- Screens belong in `presentation/screens`.
- Reusable widgets belong in `presentation/widgets`.
- DTOs belong in `data/dto`.
- API services belong in `data/services`.
- Repositories belong in `data/repositories`.
- User-facing strings belong in `lib/core/l10n/app_strings.dart`.
- Navigation should be centralized where possible.
- Role-based navigation must be explicit.

## Backend

Recommended Django structure:

```text
backend/
├── config/
├── apps/
│   ├── users/
│   ├── routes/
│   ├── receiving/
│   └── reports/
├── manage.py
└── requirements.txt
```

## Django conventions

- Models define persistent domain entities.
- Serializers define API contracts.
- Views/ViewSets expose API behavior.
- Permissions enforce role access.
- Do not put complex business logic directly inside views when it can be isolated in services.