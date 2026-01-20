#!/bin/bash
set -e

SUBSCRIPTION_ID="dabe0b83-abdb-448f-9ab0-31dfb2ab6b4b"
RESOURCE_GROUP="rg-alberta-platform-data-dev"
CAPACITY_NAME="fabricalbertadev"

echo "════════════════════════════════════════════════════════"
echo "⏸️  PAUSING FABRIC CAPACITY"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Capacity: $CAPACITY_NAME"
echo "This will STOP BILLING until you resume"
echo ""

# Check current state
CURRENT_STATE=$(az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME?api-version=2023-11-01" \
  --query 'properties.state' -o tsv)

echo "Current state: $CURRENT_STATE"

if [ "$CURRENT_STATE" = "Paused" ]; then
  echo "⚠️  Capacity is already paused!"
  exit 0
fi

if [ "$CURRENT_STATE" != "Active" ]; then
  echo "⚠️  Capacity is in state '$CURRENT_STATE' - cannot pause"
  exit 1
fi

echo ""
echo "Pausing capacity..."

# Pause the capacity
az rest --method post \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME/suspend?api-version=2023-11-01" \
  --output none

echo ""
echo "Waiting for pause to complete..."
sleep 10

# Verify state
NEW_STATE=$(az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME?api-version=2023-11-01" \
  --query 'properties.state' -o tsv)

echo ""
echo "════════════════════════════════════════════════════════"
echo "✅ CAPACITY PAUSED"
echo "════════════════════════════════════════════════════════"
echo ""
echo "State: $NEW_STATE"
echo "Billing: STOPPED"
echo ""
echo "To resume: ./resume-fabric.sh"
echo ""
