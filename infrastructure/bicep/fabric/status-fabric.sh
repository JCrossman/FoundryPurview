#!/bin/bash
set -e

SUBSCRIPTION_ID="dabe0b83-abdb-448f-9ab0-31dfb2ab6b4b"
RESOURCE_GROUP="rg-alberta-platform-data-dev"
CAPACITY_NAME="fabricalbertadev"

echo "════════════════════════════════════════════════════════"
echo "📊 FABRIC CAPACITY STATUS"
echo "════════════════════════════════════════════════════════"
echo ""

# Get capacity details
az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME?api-version=2023-11-01" \
  --query '{Name:name, Location:location, SKU:sku.name, State:properties.state, Admin:properties.administration.members[0]}' \
  -o json | jq -r '
    "Capacity: \(.Name)",
    "Location: \(.Location)",
    "SKU: \(.SKU)",
    "State: \(.State)",
    "Admin: \(.Admin)",
    "",
    "Billing: \(if .State == "Active" then "💰 ACTIVE (billing)" elif .State == "Paused" then "⏸️  PAUSED (not billing)" else .State end)"
  '

echo ""
echo "════════════════════════════════════════════════════════"
echo ""

# Get state
STATE=$(az rest --method get \
  --url "https://management.azure.com/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Fabric/capacities/$CAPACITY_NAME?api-version=2023-11-01" \
  --query 'properties.state' -o tsv)

if [ "$STATE" = "Active" ]; then
  echo "Actions:"
  echo "  • Pause: ./pause-fabric.sh"
elif [ "$STATE" = "Paused" ]; then
  echo "Actions:"
  echo "  • Resume: ./resume-fabric.sh"
fi

echo ""
