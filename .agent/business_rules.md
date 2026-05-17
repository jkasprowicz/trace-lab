# Business Rules

## Roles

### Driver

The Driver can:

- start a route
- view assigned routes
- register pickup information
- register pickup temperature
- record observations during transport
- finalize delivery steps when applicable

The Driver must not complete the Receiver's final receiving workflow.

### Receiver

The Receiver can:

- view pending deliveries
- receive a route
- register arrival temperature
- register sample integrity
- add receiving notes
- confirm receiving

After confirming receiving, the app must return to Home Receiver.

### Admin

The Admin can:

- view operational dashboards
- inspect transport records
- audit traceability
- configure users, routes and locations when implemented

## Traceability

Every operational event should preserve:

- route ID
- responsible user
- responsible role
- timestamp
- location when applicable
- relevant observations

## Temperature

The app must preserve distinct records for:

- pickup temperature
- receiving temperature
- timestamp of each temperature entry
- user responsible for each entry
- route or location context

Pickup temperature and receiving temperature must not overwrite one another.

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

## Critical navigation rule

- A completed Driver flow must return to a Driver screen.
- A completed Receiver flow must return to a Receiver screen.
- A completed Receiver flow must never navigate to a Driver screen.
