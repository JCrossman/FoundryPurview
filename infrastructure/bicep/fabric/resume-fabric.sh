#!/bin/bash
set -e

SUBSCRIPTION_ID="dabe0b83-abdb-448f-9ab0-31dfb2ab6b4b"
RESOURCE_GROUP="rg-alberta-platform-data-dev"
CAPACITY_NAME="fabricalbertadev"

echo "════════════════════════════════════════════════════════"
echo "▶️  RESUMING FABRIC CAPACITY"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Capacity: $CAPACITY_NAME"
echo "This will START BILLING"
echo ""

# Check current state
CURRENT_STATE=$(az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME?api-version=2023-11-01" \
  --query 'properties.state' -o tsv)

echo "Current state: $CURRENT_STATE"

if [ "$CURRENT_STATE" = "Active" ]; then
  echo "✅ Capacity is already active!"
  exit 0
fi

if [ "$CURRENT_STATE" != "Paused" ]; then
  echo "⚠️  Capacity is in state '$CURRENT_STATE' - cannot resume"
  exit 1
fi

echo ""
echo "Resuming capacity (takes ~30 seconds)..."

# Resume the capacity
az rest --method post \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME/resume?api-version=2023-11-01" \
  --output none

echo ""
echo "Waiting for resume to complete..."
sleep 30

# Verify state
NEW_STATE=$(az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME?api-version=2023-11-01" \
  --query 'properties.state' -o tsv)

echo ""
echo "════════════════════════════════════════════════════════"
echo "✅ CAPACITY RESUMED"
echo "════════════════════════════════════════════════════════"
echo ""
echo "State: $NEW_STATE"
echo "Billing: ACTIVE"
echo ""
echo "To pause when done: ./pause-fabric.sh"
echo ""
