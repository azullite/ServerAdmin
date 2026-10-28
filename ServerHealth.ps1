<#
Create a script that checks: Server name, OS, Uptime, Free disk space, Critical service status. Then, export the results to a CSV file. 

Get OS information and uptime
    $OS = Get-CimInstance Win32_OperatingSystem
    $Uptime = (Get-Date) - $OS.LastBootUpTime
    $Uptime.Days



Check disk space, calculate free space, and calculate total space
    $Disk = Get-CimInstance Win32_LogicalDisk | 
    Where-Object {
            $_.DeviceID -eq "C:"
    }


   $FreeSpaceGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
   $FreeSpaceGB


   $TotalSpaceGB = [math]::Round($Disk.Size / 1GB, 2) 
   $TotalSpaceGB



Check critical service status
    $Services = @(
        "EventLog",
        "W32Time",
        "Spooler",
        "WinRM" 
    )  

    Get-Service -Name $Services



Count stopped services
    $StoppedServices = Get-Service -Name $Services |
    Where-Object Status -ne "Running"

    $StoppedServices.Count



Build a report object
    $report = [PSCustomObject]@{
        ComputerName = $OS.CSName
        OSVersion = $OS.Caption
        UptimeDays = $Uptime.Days
        DiskFreeGB = $FreeSpaceGB
        DiskTotalGB = $TotalSpaceGB
        StoppedServicesCount = $StoppedServices.Count
    }   

    $report



Add health status, then add it to the report object
    if ($StoppedServices.Count -eq 0) {
        $HealthStatus = "Healthy"
    }
    else {$HealthStatus = "Unhealthy"
    }

    $report | Add-Member -MemberType NoteProperty -Name HealthStatus -Value $HealthStatus



Export report to CSV file 
    $report | Export-CSV -Path "C:\\GitHub\\ServerAdmin\\Reports/ServerHealth.csv" -NoTypeInformation
#>


# Final Script
    $OS = Get-CimInstance Win32_OperatingSystem

    $Uptime = (Get-Date) - $OS.LastBootUpTime

     $Disk = Get-CimInstance Win32_LogicalDisk | 
    Where-Object {
            $_.DeviceID -eq "C:"
    }

    $FreeSpaceGB = [math]::Round($Disk.FreeSpace / 1GB, 2)

    $TotalSpaceGB = [math]::Round($Disk.Size / 1GB, 2) 

     $Services = @(
        "EventLog",
        "W32Time",
        "Spooler",
        "WinRM" 
    )  

    $StoppedServices = Get-Service -Name $Services |
    Where-Object Status -ne "Running"

    $report = [PSCustomObject]@{
        ComputerName = $OS.CSName
        OSVersion = $OS.Caption
        UptimeDays = $Uptime.Days
        DiskFreeGB = $FreeSpaceGB
        DiskTotalGB = $TotalSpaceGB
        StoppedServicesCount = $StoppedServices.Count
    }   

    if ($StoppedServices.Count -eq 0) {
        $HealthStatus = "Healthy"
    }
    else {$HealthStatus = "Unhealthy"
    }

    $report | Add-Member -MemberType NoteProperty -Name HealthStatus -Value $HealthStatus

    $report | Export-CSV -Path "C:\\GitHub\\ServerAdmin\\Reports/ServerHealth.csv" -NoTypeInformation


