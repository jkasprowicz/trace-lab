# TransportApp Agent Instructions

This repository contains TransportApp, a system for traceability of biological sample transport.

The agent must work as a careful code maintenance assistant.

## Stack

Frontend:
- Flutter
- Feature-based architecture
- DTOs, services, repositories, screens and widgets separated by responsibility

Backend:
- Django
- Django REST Framework

## Core user roles

- Driver: route execution, pickup records and transport temperatures.
- Receiver: sample reception, arrival temperature and integrity checks.
- Admin: dashboards, reports and configuration.

## Critical domain rule

Never mix Driver and Receiver navigation flows.

After Driver actions, return to Driver screens.
After Receiver actions, return to Receiver screens.
After successful receiving, return to Home Receiver, not Home Driver.

## Language and localization rules

The source code may use English names for files, classes, variables and methods.

All user-facing text must be in Brazilian Portuguese.

Do not leave visible UI labels, buttons, snackbars, dialogs, error messages or empty states in English.

Prefer centralized strings in:

`lib/core/l10n/app_strings.dart`

When editing a screen, check and translate all user-facing strings in that screen.

Do not rename code symbols only for translation unless the task explicitly asks for refactoring.

## Required workflow before editing

Before changing code, the agent must:

1. Inspect the relevant files.
2. Identify the affected flow.
3. Explain the likely cause.
4. Propose the smallest safe change.
5. Apply the change.
6. List the modified files.
7. Suggest manual tests.

## Engineering rules

- Do not rewrite entire screens unless strictly necessary.
- Do not change API contracts without checking backend and frontend together.
- Do not move files unless the task explicitly requires refactoring.
- Prefer small, reversible changes.
- Preserve existing naming conventions.
- Preserve feature-based folder structure.
- Avoid business logic directly inside UI widgets when possible.
- Keep Driver and Receiver logic explicitly separated.

## Verification

Flutter:

```bash
flutter analyze
flutter test
flutter run
```
Django:

```bash
python manage.py check
python manage.py test
python manage.py runserver
```
