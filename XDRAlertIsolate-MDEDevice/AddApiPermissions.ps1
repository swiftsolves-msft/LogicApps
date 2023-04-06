# This script grants the necessary Microsoft Graph API permissions to the Service Principal.
# Before running, change the $TenantID (line5) to your AAD Tenant ID and the $DisplayNameofMSI (line6) to the name of your Logic App
# This script requires the AzureAD Powershell Module,  Install-Module AzureAD

$TenantID=""  #AAD Tenant Id
$DisplayNameOfMSI="XDRAlertIsolate-MDEDevice" # Name of the managed identity

Connect-AzureAD -TenantId $TenantID

$MI = (Get-AzureADServicePrincipal -Filter "displayName eq '$DisplayNameOfMSI'")

Start-Sleep -Seconds 5


#Defender for Endpoint API - Machine.Isolate
$GraphAppId = "fc780465-2017-40d4-a0c5-307022471b92"
$PermissionName1 = "Machine.Isolate"

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole1 = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName1 -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
-ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole1.Id

Start-Sleep -Seconds 5

#Defender for Endpoint API - AdvancedQuery.Read.All
$GraphAppId = "fc780465-2017-40d4-a0c5-307022471b92"
$PermissionName2 = "AdvancedQuery.Read.All"

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole1 = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName2 -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
-ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole1.Id

Start-Sleep -Seconds 5

#Microsoft Graph API - Policy.Read.All
$GraphAppId = "00000003-0000-0000-c000-000000000000"
$PermissionName2 = "Policy.Read.All"

$GraphServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$GraphAppId'"
$AppRole1 = $GraphServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName2 -and $_.AllowedMemberTypes -contains "Application"}
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
-ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole1.Id