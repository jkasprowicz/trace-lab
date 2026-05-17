# Workflows

## Driver workflow

1. Login as Driver.
2. Open Home Driver.
3. View assigned route.
4. Start route.
5. Visit pickup location.
6. Register pickup temperature.
7. Confirm pickup.
8. Continue route.
9. Finish transport/delivery step.
10. Return to Home Driver or route summary.

## Receiver workflow

1. Login as Receiver.
2. Open Home Receiver.
3. View pending routes or deliveries.
4. Select route to receive.
5. Register receiver name.
6. Register arrival temperature.
7. Register integrity status.
8. Add notes if needed.
9. Confirm receiving.
10. Show success state.
11. Return to Home Receiver.

## Common bug pattern

If Receiver success returns to Home Driver, inspect:

- success screen navigation target
- route names/constants
- role-based home resolver
- shared success component
- receiving feature navigation
- auth role state