<#

Active Directory - Retrieve AD users, check if accounts enabled or not, show last login, export results to CSV.

Get AD module, import module
    Get-Module ActiveDirectory -ListAvailable
    Import-Module ActiveDirectory



Retrieve all users in AD, retrieve useful info
    Get-ADUser -Filter *

    Get-ADUser -Filter * -Properties Department, LastLogonDate | 
    Select-Object Name,Enabled,Department,LastLogonDate



Store results in a variable
    $Users = Get-ADUser -Filter * -Properties Department, LastLogonDate



Build report and view it
    $Report = foreach ($User in $Users) {

        [PSCustomObject]@{
            Name          = $User.Name
            Enabled       = $User.Enabled
            Department    = $User.Department
            LastLogonDate = $User.LastLogonDate
         }
    }   

    $report



Export to CSV file
    $report | export-csv ".\Reports\ADUserAudit.csv" -notypeinformation



Retrieve disabled accounts and display them
    $DisabledUsers = Get-ADUser -Filter 'Enabled -eq $false' -Properties Name,Department,LastLogonDate

    $disabledusers



Export disabled account report to CSV file
    $DisabledUsers | Select-Object Name,Department,LastLogonDate |
    Export-Csv ".\Reports\DisabledUsers.csv" -NoTypeInformation




Find inactive users
    $Date = (Get-Date).AddDays(-90)

    Get-ADUser -Filter * -Properties LastLogonDate |
    Where-Object {
        $_.LastLogonDate -lt $Date
    }



Export inactive user report in CSV file
    $InactiveUsers | Select-Object Name,Department,LastLogonDate | 
    Export-Csv ".\Reports\InactiveUsers.csv" -NoTypeInformation


#>
#Final Script

Import-module Activedirectory 

$users = get-aduser -filter * -properties Department, LastLogonDate

$report = foreach ($user in $users) {
        [pscustomobject]@{
            Name          = $User.Name
            Enabled       = $User.Enabled
            Department    = $User.Department
            LastLogonDate = $User.LastLogonDate
         }
    }   

 $report | export-csv ".\Reports\ADUserAudit.csv" -notypeinformation
