# Project Context

TransportApp is a traceability system for biological sample transport.

The repository is split into two main applications:

- `mobile/`: Flutter client used by Driver, Receiver and Admin flows.
- `backend/`: Django + Django REST API that supports transport, receiving and audit data.

The system is responsible for recording:

- who handled the samples
- where the collection or receiving event happened
- route start and completion
- pickup temperature
- receiving temperature
- integrity status at arrival
- timestamps for operational events
- the role responsible for each action

The main product goal is to reduce failures in the pre-analytical phase by improving traceability, temperature control and accountability during transport.

## Maintenance focus

- Prefer maintaining the existing implementation over rewriting features.
- Keep Driver and Receiver flows explicitly separated.
- Preserve route, temperature, timestamp and responsible-user information.
- Treat `mobile/lib/core/l10n/app_strings.dart` as the canonical Flutter strings file.
- Use `lib/core/l10n/app_strings.dart` only as an agent-compatibility entry point when needed.
