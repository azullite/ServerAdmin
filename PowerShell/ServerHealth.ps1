
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
   $totalspaceGB



Check critical service status
