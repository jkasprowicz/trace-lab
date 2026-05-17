
---

## 3. Arquivo `.agent/project_context.md`

```md
# Project Context — TransportApp

TransportApp is an application for traceability of biological sample transport.

The system records:

- who collected the samples
- where samples were collected
- route start and end
- pickup temperature
- receiving temperature
- sample integrity at arrival
- timestamps
- user role responsible for each action

The main goal is to reduce failures in the pre-analytical phase by improving traceability, temperature control and accountability during transport.

The project currently has existing Flutter screens and Django API flows. The agent must prioritize maintaining and improving the existing implementation instead of rebuilding the application from scratch.