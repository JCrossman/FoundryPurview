#!/bin/bash
# Fabric Capacity Management - Quick Reference
# Add to your shell profile for easy access

# Function to check Fabric status
fabric-status() {
    ~/Desktop/FoundryPurview/infrastructure/bicep/fabric/status-fabric.sh
}

# Function to pause Fabric (stop billing)
fabric-pause() {
    ~/Desktop/FoundryPurview/infrastructure/bicep/fabric/pause-fabric.sh
}

# Function to resume Fabric (start billing)
fabric-resume() {
    ~/Desktop/FoundryPurview/infrastructure/bicep/fabric/resume-fabric.sh
}

# Daily reminders
alias work-start='fabric-resume && echo "☕ Capacity resuming... Grab coffee while it starts (30s)"'
alias work-end='fabric-pause && echo "🏠 Capacity paused! Billing stopped. Have a great evening!"'

echo "Fabric management functions loaded!"
echo ""
echo "Quick Commands:"
echo "  fabric-status  - Check if capacity is running/paused"
echo "  fabric-pause   - Pause capacity (stop billing) 💰"
echo "  fabric-resume  - Resume capacity (start billing)"
echo "  work-start     - Resume + reminder"
echo "  work-end       - Pause + reminder"
echo ""
echo "Add to ~/.zshrc or ~/.bash_profile:"
echo "  source ~/Desktop/FoundryPurview/infrastructure/bicep/fabric/fabric-aliases.sh"
