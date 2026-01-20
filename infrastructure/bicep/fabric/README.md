# Microsoft Fabric Capacity Deployment

## ✅ Current Status

**Fabric Capacity Deployed**: January 20, 2026

- **Name**: fabricalbertadev
- **Location**: Canada Central
- **SKU**: F2 (2 Capacity Units)
- **State**: Active
- **Resource Group**: rg-alberta-platform-data-dev
- **Admin**: admin@MngEnvMCAP516709.onmicrosoft.com

## 💰 Cost Information

**Base Cost**: $988/month (24 hours/day)

**With Auto-Pause**: ~$400/month (60% savings)
- Active time: ~10 hours/day (work hours)
- Paused time: ~14 hours/day (nights/weekends)

## ⏸️ IMPORTANT: Configure Auto-Pause

**Auto-pause must be configured in the Fabric portal (not available via ARM/CLI)**

### Steps to Enable Auto-Pause:

1. **Go to Fabric Admin Portal**
   - URL: https://app.fabric.microsoft.com/admin
   - Or: Fabric Portal → Settings (gear icon) → Admin Portal

2. **Navigate to Capacity Settings**
   - Click "Capacity settings" in left menu
   - Find "fabricalbertadev" in the list
   - Click the capacity name

3. **Enable Auto-Pause**
   - Scroll to "Auto pause inactive capacity"
   - Toggle to **Enabled**
   - Set delay: **30 minutes** (recommended)
   - Click "Apply"

4. **Verify Settings**
   - Status should show "Auto-pause: Enabled"
   - Delay should show "30 minutes"

### What Auto-Pause Does

- **Automatically pauses** the capacity after 30 minutes of inactivity
- **Automatically resumes** when you access Fabric workspace
- **Saves ~60%** on costs (you only pay when active)
- **No data loss** - all data and configs preserved

### When Capacity Pauses

The capacity will pause when:
- No active queries running
- No data pipelines processing
- No Power BI reports refreshing
- No notebooks executing
- 30 minutes of inactivity elapsed

### When Capacity Resumes

The capacity resumes automatically when:
- You open a workspace
- A scheduled pipeline runs
- A Power BI report refreshes
- Anyone accesses Fabric workspaces using this capacity
- Resume time: ~30 seconds

## 🚀 Deployment

### Deploy Fabric Capacity

```bash
cd infrastructure/bicep/fabric
./deploy-fabric.sh dev
```

### Verify Deployment

```bash
az rest --method get \
  --url "https://management.azure.com/subscriptions/<subscription-id>/resourceGroups/rg-alberta-platform-data-dev/providers/Microsoft.Fabric/capacities/fabricalbertadev?api-version=2023-11-01" \
  --query '{Name:name, Location:location, SKU:sku.name, State:properties.state}' -o json
```

### List All Capacities

```bash
az rest --method get \
  --url "https://management.azure.com/subscriptions/<subscription-id>/providers/Microsoft.Fabric/capacities?api-version=2023-11-01" \
  --query "value[].{Name:name, Location:location, SKU:sku.name, State:properties.state}" -o table
```

## 📊 Next Steps

### 1. Configure Auto-Pause (Required!)
Follow steps above to enable auto-pause and save 60% on costs.

### 2. Create Fabric Workspace

1. Go to: https://app.fabric.microsoft.com
2. Click "Workspaces" in left nav
3. Click "+ New workspace"
4. Name: "Alberta Platform Dev"
5. Advanced:
   - License mode: **Fabric capacity**
   - Capacity: **fabricalbertadev**
6. Click "Apply"

### 3. Create Lakehouse

1. In workspace, click "+ New"
2. Select "Lakehouse"
3. Name: "alberta_data"
4. Click "Create"

### 4. Set Up Data Zones

Create folders in lakehouse:
- `bronze/` - Raw data from sources
- `silver/` - Cleaned and validated data
- `gold/` - Aggregated data for reporting

### 5. Create First Pipeline

1. In workspace, click "+ New" → "Data pipeline"
2. Name: "ingest-healthcare-data"
3. Add activities to pull from Alberta Open Data
4. Schedule for daily refresh

## 🏷️ Tags

The capacity is tagged with:

```json
{
  "project": "alberta-platform",
  "environment": "dev",
  "owner": "jcrossman@microsoft.com",
  "createdBy": "arm-template",
  "createdDate": "2026-01-20",
  "workload": "data",
  "autoPause": "enabled"
}
```

## 📁 Files

- `fabric-capacity.json` - ARM template for Fabric capacity
- `fabric-capacity.parameters.json` - Parameters (SKU, location, admin)
- `deploy-fabric.sh` - Deployment script
- `README.md` - This file

## 🔧 Troubleshooting

### Capacity Not Appearing in Portal
- Wait 2-3 minutes for Azure sync
- Refresh the Fabric portal
- Check you're signed in as the admin user

### Can't Access Fabric
- Ensure you're signed in as: admin@MngEnvMCAP516709.onmicrosoft.com
- Verify capacity is "Active" state
- Check workspace is assigned to the capacity

### Auto-Pause Not Working
- Verify it's enabled in Fabric Admin Portal
- Check delay is set to 30 minutes
- Allow 30 minutes of inactivity before expecting pause

### Costs Higher Than Expected
- Verify auto-pause is actually enabled (check portal)
- Check capacity isn't being kept active by scheduled jobs
- Review activity logs to see usage patterns

## 📚 Resources

- **Fabric Portal**: https://app.fabric.microsoft.com
- **Fabric Admin**: https://app.fabric.microsoft.com/admin
- **Fabric Docs**: https://learn.microsoft.com/fabric/
- **Capacity Management**: https://learn.microsoft.com/fabric/admin/capacity-settings

---

**Deployed**: January 20, 2026  
**Status**: Active  
**Auto-Pause**: Needs configuration in portal  
**Next**: Configure auto-pause to save 60% on costs
