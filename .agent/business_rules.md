
---

## 5. Arquivo `.agent/business_rules.md`

```md
# Business Rules

## Roles

### Driver

The Driver can:

- start a route
- view assigned routes
- register pickup information
- register pickup temperature
- record observations during transport
- finalize delivery flow when applicable

The Driver should not perform the Receiver's final receiving workflow.

### Receiver

The Receiver can:

- view pending deliveries
- receive a route
- register arrival temperature
- register sample integrity
- add receiving notes
- confirm receiving

After confirming receiving, the Receiver must return to Home Receiver.

### Admin

The Admin can:

- view operational dashboards
- inspect transport records
- audit traceability
- configure users, routes and locations when implemented

## Temperature

The app must preserve:

- pickup temperature
- receiving temperature
- timestamp of each temperature
- responsible user
- route/location context

## Traceability

Every operational event should preserve:

- route ID
- user
- role
- date/time
- location when applicable
- relevant observations

## User-facing language

TransportApp is intended for Brazilian Portuguese users.

All visible interface text must be in Portuguese:

- screen titles
- buttons
- form labels
- validation messages
- success messages
- error messages
- empty states
- dialogs
- snackbars

Internal code identifiers may remain in English.

## Critical rule

A completed Receiver flow must never navigate to a Driver screen.