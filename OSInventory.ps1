<#
OS Inventory - gather OS info, work w/PS objects, create reports, export to CSV file.

Basic query for OS data on local computer
    get-ciminstance Win32_OperatingSystem
    cd "C:\GitHub\ServerAdmin\PowerShell"
    .\OSInventory.ps1



Retrieve useful properties from the OS object
    get-ciminstance win32_operatingsystem | 
    select-object csname, caption, version



Store above results in a variable and display it    
    $osinfo = get-ciminstance Win32_OperatingSystem |
    select-object csname, caption, Version

    $osinfo



Create a custom report object  
    $os = get-ciminstance win32_operatingsystem
    [pscustomobject]@{
        ComputerName = $os.csname
        OperatingSystem = $os.caption
        Version = $os.version
    } 



Store the report in a variable and display it
    $os = get-ciminstance Win32_OperatingSystem

    $report = [pscustomobject]@{
        ComputerName = $os.CSName
        OperatingSystem = $os.Caption
        Version = $os.version
    }

    $report



Export the report to a CSV file with and without type information
    $report | export-csv ".\Reports\OSInventory.csv" -NoTypeInformation 
    $report | export-csv ".\Reports\OSInventoryWithType.csv"

    .\OSInventory.ps1 



Add more useful info to the report and display it
    $report = [pscustomobject]@{
        ComputerName = $os.csname
        OperatingSystem = $os.caption
        Version = $os.version
        BuildNumber = $os.BuildNumber
        LastBootTime = $os.LastBootUpTime
    }

    $report



Export the updated report to the 2 CSV files
    $report | export-csv ".\PowerShell\Reports\OSInventory.csv" -NoTypeInformation
    $report | export-csv ".\PowerShell\Reports\OSInventoryWithType.csv" 

    #>



#Final Script
    $OS = Get-CimInstance Win32_OperatingSystem
    $report = [pscustomobject]@{
        ComputerName = $OS.CSName
        OperatingSystem = $OS.Caption
        Version = $OS.Version
        BuildNumber = $os.BuildNumber
        LastBootTime = $os.lastbootuptime
    }
    $report | export-csv ".\PowerShell\Reports\OSInventory.csv" -NoTypeInformation
    $report | export-csv ".\PowerShell\Reports\OSInventoryWithType.csv"

    $report