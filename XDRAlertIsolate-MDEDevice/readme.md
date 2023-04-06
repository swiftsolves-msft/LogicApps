# XDRAlertIsolate-MDEDevice

author: Nathan Swift

The following Logic App is designed to poll Security Graph frequently 1 minute for High Severity Alerts. Upon a High Alert trigger and lookup DeviceId and Isolate Device

## Quick Deployment

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FXDRAlertIsolate-MDEDevice%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FXDRAlertIsolate-MDEDevice%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

## Prerequisites

- None

## After Deployment

- Grant the Logic App Managed Identity access to the Microsoft Graph SecurityEvents.Read.All & Machine.Isolate & AdvancedQuery.Read.All which can be done with the included PowerShell script [AddApiPermissions.ps1](https://raw.githubusercontent.com/swiftsolves-msft/LogicApps/master/XDRAlertIsolate-MDEDevice/AddApiPermissions.ps1)
