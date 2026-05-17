---
name: transport-domain-rules
description: Use this skill when a task involves biological sample transport workflows, pre-analytical traceability, temperature control, route events, Driver actions or Receiver actions.
---

# Transport Domain Rules Skill

TransportApp exists to improve traceability in biological sample transport.

## Domain priorities

- preserve chain of custody
- preserve temperature records
- preserve timestamps
- preserve responsible user
- separate pickup from receiving
- separate Driver from Receiver responsibilities
- keep user-facing language in Brazilian Portuguese

## Driver

Driver records transport execution and pickup-related data.

## Receiver

Receiver records arrival, receiving temperature and integrity status.

## Critical workflow rule

After successful receiving, the app must return to Home Receiver.

## Do not

- mix Driver and Receiver screens
- overwrite pickup temperature with receiving temperature
- lose route ID
- lose timestamp
- lose responsible user
- treat receiving as the same event as pickup