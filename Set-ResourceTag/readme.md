# Set-ResourceTag
author: Nathan Swift

This Logic App will trigger from a KQL Alert from AzureActivity Table read the resource and check if a Tag createdby or a tag you define at deployment is present, if that tag is not present it will add the Caller who /write to the Azure Resource as a new tag. If that tag is present then it will not update the tag.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FSet-ResourceTag%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FSet-ResourceTag%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

**Additional Post Install Notes:**

The Logic App creates and uses a Managed System Identity (MSI) to authenticate and authorize against management.azure.com to obtain azure resource information and write a tag to the resource.

Assign RBAC 'Reader' and 'Tag Contributor' role to the Logic App at the MG or Subscription level.

**An example of a KQL Alert**

To use send your Azure Subscription Activity logs to a Log analytics Workspace and Create a KQL Alert and Action group to trigger this Logic App

```id: 27dda424-1dbe-4236-9dd5-c484b23111a5
name: ActivityLogRescourceWriteAlert
description: |
  'Using the Activity Logs to generate an alert when PS,CLI, API or terraform generates a Azure Resource.'
severity: Information
requiredDataConnectors:
  - connectorId: AzureActivity
    dataTypes:
      - AzureActivity
queryFrequency: 5m
queryPeriod: 5m
triggerOperator: gt
triggerThreshold: 0
query: |
AzureActivity
| where OperationNameValue contains "write"
| where OperationNameValue <> "Microsoft.Resources/tags/write"
| extend ShortResourceId1 = tostring(split(_ResourceId, '/', 7))
| extend ShortResourceId2 = tostring(split(_ResourceId, '/', 8))
| extend ShortResourceId1 = tostring(parse_json(ShortResourceId1)[0])
| extend ShortResourceId2 = tostring(parse_json(ShortResourceId2)[0])
| extend ShortResourceId = strcat(ShortResourceId1, '/', ShortResourceId2)
| project SubscriptionId, ResourceGroup, ResourceProviderValue, ShortResourceId, _ResourceId, Caller