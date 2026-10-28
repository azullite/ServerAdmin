<#
Repository restructuring - Create files, move files, delete files. Update file paths in scripts. Using hardcoded paths/fixed location.



Create new file - Repostructure.ps1 located in ServerAdmin directory. 
    new-item -path "C:/GitHub/ServerAdmin/RepoStructure.ps1" -ItemType File



Move Reports folder out of PowerShell folder and to ServerAdmin folder.
    Move-Item -Path "C:\GitHub\ServerAdmin\PowerShell\Reports" -Destination "C:\GitHub\ServerAdmin\Reports"



Move OSInventory.ps1 and ServerHealth.ps1 from PS folder to ServerAdmin folder
    Move-Item -Path "C:\GitHub\ServerAdmin\PowerShell\*.ps1" -Destination "C:\GitHub\ServerAdmin"



Delete 3 folders from directory - AD, PS, Firewalls
    Remove-Item "C:\GitHub\ServerAdmin\PowerShell", "C:\GitHub\ServerAdmin\Firewalls", "C:\GitHub\ServerAdmin\ActiveDirectory" -recurse -Confirm



Find items / .ps1 files with old paths in them, Bulk update file paths in scripts
    Get-ChildItem "C:\GitHub\ServerAdmin" -Filter "*.ps1" -Recurse |
    Select-String "C:/GitHub/ServerAdmin/PowerShell/Reports"


    Get-ChildItem "C:\GitHub\ServerAdmin" -Filter "*.ps1" -Recurse |
    ForEach-Object {
            (Get-Content $_.FullName) -replace 'C:\\GitHub\\ServerAdmin\\PowerShell\\Reports', 
            'C:\\GitHub\\ServerAdmin\\Reports' | 
            Set-Content $_.FullName
    }


     Get-ChildItem "C:\GitHub\ServerAdmin" -Filter "*.ps1" -Recurse |     
     Select-String -SimpleMatch ".\PowerShell\Reports\"



    Get-ChildItem "C:\GitHub\ServerAdmin" -Filter "*.ps1" -Recurse |
    ForEach-Object {
        (Get-Content $_.FullName -Raw).
         Replace('.\Reports\', '.\Reports\') |
         Set-Content $_.FullName
        }

#>

#More to follow