# Microsoft Fabric Capacity Management

## ✅ Current Status

**Fabric Capacity Deployed**: January 20, 2026

- **Name**: fabricalbertadev
- **Location**: Canada Central
- **SKU**: F2 (2 Capacity Units)
- **State**: Active
- **Resource Group**: rg-alberta-platform-data-dev
- **Admin**: admin@MngEnvMCAP516709.onmicrosoft.com

## 💰 Cost Information

**Base Cost**: $988/month (24 hours/day, 7 days/week)

**⚠️ IMPORTANT**: Microsoft Fabric does NOT support automatic pause. You must manually pause/resume to save costs.

### Manual Pause/Resume Strategy

**Recommended Usage Pattern**:
- **Pause** when done working (evenings, weekends)
- **Resume** when you start working (mornings)
- **Savings**: 100% when paused (billing stops completely)

**Example Savings**:
- Work 8 hours/day, 5 days/week = 40 hours active
- Paused 128 hours/week
- **Cost**: ~$290/month (vs $988 if running 24/7)
- **Savings**: 70%

## 🎮 Quick Commands

### Check Status
```bash
cd infrastructure/bicep/fabric
./status-fabric.sh
```

### Pause Capacity (Stop Billing)
```bash
./pause-fabric.sh
```
**Use when**: Done for the day, going home, weekends

### Resume Capacity (Start Billing)
```bash
./resume-fabric.sh
```
**Use when**: Starting work, need to run pipelines, demo time

## 📋 Daily Workflow

### Morning Routine (Start Work)
```bash
cd ~/Desktop/FoundryPurview/infrastructure/bicep/fabric
./resume-fabric.sh
# Wait 30 seconds, then open Fabric portal
```

### Evening Routine (End Work)
```bash
./pause-fabric.sh
# Capacity paused, billing stopped
```

### Check If Paused
```bash
./status-fabric.sh
# Shows current state and billing status
```

## ⚠️ Important Notes

1. **Pause Before Long Breaks**: Always pause before leaving for the day
2. **Resume Takes 30 Seconds**: Plan ahead, resume before you need it
3. **No Data Loss**: Pausing doesn't affect your data or workspaces
4. **Check Status Weekly**: Run `status-fabric.sh` to verify state
5. **Set Reminders**: Add calendar reminders to pause evenings/weekends

## 🔧 Manual Management via Portal

### Azure Portal
1. Go to: https://portal.azure.com
2. Navigate to: `rg-alberta-platform-data-dev` → `fabricalbertadev`
3. Click "Stop" button to pause
4. Click "Start" button to resume

### Fabric Portal
- URL: https://app.fabric.microsoft.com
- Status visible but cannot pause/resume from here
- Must use Azure Portal or scripts

## 💡 Cost Optimization Tips

### Best Practices
1. **Pause Every Evening**: Save ~14 hours/day
2. **Pause All Weekend**: Save 48 hours/week
3. **Check Status Monday Morning**: Verify it's paused before starting
4. **Use Scheduled Reminders**: 6pm pause, 9am resume
5. **Monitor Costs Weekly**: Check Azure Cost Management

### When to Keep Running
- **Running data pipelines** (will fail if paused mid-run)
- **Active Power BI reports** being viewed
- **Scheduled refreshes** about to run
- **Customer demos** scheduled soon

### When to Pause
- ✅ End of work day
- ✅ Weekends (if not demoing)
- ✅ Holidays
- ✅ Any time you're not actively using Fabric
- ✅ Before going on vacation

## 📊 Cost Tracking

### Monthly Cost Examples

| Usage Pattern | Hours Active/Week | Monthly Cost | Savings |
|---------------|-------------------|--------------|---------|
| 24/7 (always on) | 168 | $988 | 0% |
| Work hours (8am-6pm, M-F) | 50 | $290 | 70% |
| Part-time (4 hrs/day, M-F) | 20 | $116 | 88% |
| Demo only (2 hours/week) | 2 | $12 | 99% |

**Your Current**: 24/7 until you pause = **$988/month**

### Estimated Savings Calculator
```
Hourly rate = $988 / 730 hours = $1.35/hour
Hours paused per month = X
Savings = X × $1.35
```

## 🚀 Deployment

### Deploy New Fabric Capacity
```bash
cd infrastructure/bicep/fabric
./deploy-fabric.sh dev
```

### Delete Fabric Capacity
```bash
az rest --method delete \
  --url "https://management.azure.com/subscriptions/dabe0b83-abdb-448f-9ab0-31dfb2ab6b4b/resourceGroups/rg-alberta-platform-data-dev/providers/Microsoft.Fabric/capacities/fabricalbertadev?api-version=2023-11-01"
```

## 📚 Scripts Reference

### status-fabric.sh
- Shows capacity state (Active/Paused)
- Shows billing status
- Shows admin and location
- Suggests next action

### pause-fabric.sh
- Checks if already paused
- Suspends the capacity
- Stops billing immediately
- Verifies pause completed

### resume-fabric.sh
- Checks if already active
- Resumes the capacity (30 seconds)
- Starts billing
- Verifies resume completed

### deploy-fabric.sh
- Deploys new Fabric F2 capacity
- Uses ARM template
- Applies tags
- Takes 5-10 minutes

## 🔍 Troubleshooting

### "Capacity Not Found"
- Verify name: `fabricalbertadev`
- Check resource group: `rg-alberta-platform-data-dev`
- Ensure subscription ID is correct

### "Cannot Pause - Already Paused"
- Run `./status-fabric.sh` to check state
- Already paused = already saving money!

### "Cannot Resume - Already Active"
- Run `./status-fabric.sh` to check state
- Already active = ready to use!

### "Unauthorized Error"
- Ensure you're logged in: `az login`
- Verify you have permissions on the resource group
- Check Azure CLI is up to date

### "Workspace Not Accessible"
- Capacity might be paused - run `./resume-fabric.sh`
- Wait 30 seconds after resume
- Refresh Fabric portal

## 📖 Next Steps

### 1. Test Pause/Resume
```bash
./status-fabric.sh    # Check current state
./pause-fabric.sh     # Pause it
./status-fabric.sh    # Verify paused
./resume-fabric.sh    # Resume it
./status-fabric.sh    # Verify active
```

### 2. Create Workspace
1. Resume capacity: `./resume-fabric.sh`
2. Go to: https://app.fabric.microsoft.com
3. Workspaces → "+ New workspace"
4. Name: **Alberta Platform Dev**
5. License mode: **Fabric capacity**
6. Capacity: **fabricalbertadev**

### 3. Create Lakehouse
1. In workspace, click "+ New" → "Lakehouse"
2. Name: **alberta_data**
3. Create folders: `bronze/`, `silver/`, `gold/`

### 4. Set Up Daily Routine
- **Morning**: Resume capacity when starting work
- **Evening**: Pause capacity when done
- **Weekly**: Check status and costs on Mondays

## 🏷️ Tags

```json
{
  "project": "alberta-platform",
  "environment": "dev",
  "owner": "jcrossman@microsoft.com",
  "createdBy": "arm-template",
  "createdDate": "2026-01-20",
  "workload": "data",
  "autoPause": "manual"
}
```

Note: `autoPause` tag updated to "manual" since automatic pause is not available.

## 📁 Files

- `fabric-capacity.json` - ARM template
- `fabric-capacity.parameters.json` - Parameters
- `deploy-fabric.sh` - Deploy capacity
- `pause-fabric.sh` - Pause capacity (stop billing) ⭐
- `resume-fabric.sh` - Resume capacity (start billing) ⭐
- `status-fabric.sh` - Check capacity status ⭐
- `README.md` - This file

## 📚 Resources

- **Fabric Portal**: https://app.fabric.microsoft.com
- **Azure Portal**: https://portal.azure.com
- **Fabric Docs**: https://learn.microsoft.com/fabric/
- **Capacity Management**: https://learn.microsoft.com/fabric/admin/capacity-settings

---

**Deployed**: January 20, 2026  
**Status**: Active (billing)  
**Management**: Manual pause/resume  
**Cost**: $988/month (24/7) or ~$290/month (work hours only)  
**Next**: PAUSE WHEN DONE WORKING to save money! 💰

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
