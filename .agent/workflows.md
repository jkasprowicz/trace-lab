# Workflows

## Driver workflow

1. Login as Driver.
2. Open Home Driver.
3. View assigned route.
4. Start route.
5. Visit pickup location.
6. Register pickup temperature.
7. Confirm pickup.
8. Continue route execution.
9. Finish transport or delivery step.
10. Return to Home Driver or route summary.

## Receiver workflow

1. Login as Receiver.
2. Open Home Receiver.
3. View pending routes or deliveries.
4. Select route to receive.
5. Register receiver name when required.
6. Register arrival temperature.
7. Register integrity status.
8. Add notes if needed.
9. Confirm receiving.
10. Show success state.
11. Return to Home Receiver.

## Admin workflow

1. Login as Admin.
2. Open admin dashboard or management area.
3. Inspect transport records, reports or configuration sections.
4. Review traceability data without interfering with Driver or Receiver task flow.

## Common bug pattern

If Receiver success returns to Home Driver, inspect:

- success screen navigation target
- route names and route constants
- role-based home resolver
- shared success components
- receiving feature navigation handlers
- auth role state used during redirection
