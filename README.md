# ServerAdmin

PowerShell 

    OSInventory.ps1
        Gather local OS info, work with PS objects, create reports, export data to CSV files.

    ServerHealthCheck.ps1
        Create a report object containing computer name, OS version, uptime in days, free disk space, total disk space, stopped service count, and health status.

    RepoStructure.ps1
        Move all files to ServerAdmin folder. Move Reports folder to ServerAdmin folder. Delete PS, AD, Firewalls folders. Update scripts with new paths.
        NEXT: Demonstrate dynamic paths with $PSScriptRoot. 

    ActiveDirectory.ps1 (CURRENT)
        Retrieve AD users, check if accounts enabled or not, show last login, export results to CSV.

    FirewallCompliance.ps1 (SOON-ISH)
        Automated firewall compliance and reporting system. Script verifies firewall configuration, tracked rules, exports timestamped compliance reports. 
        NEXT: Have script email the report automatically. 

    Reports
        OSInventory.csv
        OSInventoryWithType.csv
        ServerHealth.csv

