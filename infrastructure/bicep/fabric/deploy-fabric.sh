#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV=${1:-dev}

echo "================================================"
echo "🚀 Microsoft Fabric Capacity Deployment"
echo "================================================"
echo ""
echo "Environment:  $ENV"
echo ""

# Deploy Fabric capacity
az deployment group create \
  --name fabric-capacity-$ENV-$(date +%Y%m%d-%H%M%S) \
  --resource-group rg-alberta-platform-data-$ENV \
  --template-file "$SCRIPT_DIR/fabric-capacity.json" \
  --parameters "$SCRIPT_DIR/fabric-capacity.parameters.json" \
  --query '{Status:properties.provisioningState, Capacity:properties.outputs}' \
  -o json

echo ""
echo "================================================"
echo "✅ FABRIC CAPACITY DEPLOYED"
echo "================================================"
echo ""
echo "📋 Next Steps:"
echo "   1. Configure auto-pause in Fabric portal"
echo "   2. Create workspace: Alberta Platform Dev"
echo "   3. Create lakehouse: alberta_data"
echo ""
