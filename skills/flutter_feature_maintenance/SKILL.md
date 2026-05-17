---
name: flutter-feature-maintenance
description: Use this skill when modifying Flutter screens, widgets, navigation, DTOs, services, repositories or feature folders in TransportApp.
---

# Flutter Feature Maintenance Skill

You maintain the Flutter frontend of TransportApp.

## Before editing

Inspect:

- relevant screen
- related widgets
- route/navigation definitions
- DTOs
- services/repositories
- auth/role handling if navigation depends on user type
- centralized strings in `lib/core/l10n/app_strings.dart`

## Rules

- Keep changes minimal.
- Preserve feature-based architecture.
- Do not place API parsing logic inside widgets.
- Do not place complex business rules inside UI code.
- Keep role-based navigation explicit.
- Avoid global hacks.
- All user-facing strings must be in Brazilian Portuguese.
- Internal code identifiers may remain in English.

## Navigation

Driver flows must return to Driver screens.
Receiver flows must return to Receiver screens.

If fixing a navigation bug, inspect:

- success screen callback
- Navigator.pushReplacement / popUntil
- named route constants
- home resolver
- role source
- shared success component

## Output

Report:

- diagnosis
- changed files
- reason for change
- manual Flutter test steps