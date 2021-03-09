armclient login

$SubId = ""
$rgname = ""
$systemTopicName = "azpolicychange"
$eventSubName = "azpolicysubscribe"

# c:\temp\systopic.json
<#

{
    "properties": {
        "topicType": "Microsoft.PolicyInsights.PolicyStates",
        "source": "/subscriptions/{subscriptionId}" // must be the same as the subscription in the resource id
    },
    "location": "global"
}


#>


# c:\temp\eventhandler.json
<#

{
    "properties": {
		"destination": 
		{
			"endpointType": "WebHook",
			"properties": 
			{
				"endpointUrl": "HTTPS://LogicAppRequestsURL",
				"maxEventsPerBatch": 1,
				"preferredBatchSizeInKilobytes": 64
			}
		},
        "filter": {
            "includedEventTypes": [
                "Microsoft.PolicyInsights.PolicyStateCreated", "Microsoft.PolicyInsights.PolicyStateChanged", "Microsoft.PolicyInsights.PolicyStateDeleted" // any or all of these. Can also set the property to null to default to all.
            ]
        },
        "eventDeliverySchema": "EventGridSchema"
    }
}

#>

#health of resource in body

# policy or resource, Policy State on 1st scan (policy or resource) 


Set-AzContext -Subscription $SubId

$armcall = "/subscriptions/" + $SubId + "/providers/Microsoft.Features/providers/Microsoft.PolicyInsights/features/policyStateChangeNotifications/register?api-version=2015-12-01"

armclient POST $armcall

# Check to ensure the Subscription and Feature is whitelisted and Registered
Get-AzProviderFeature -ProviderNamespace "Microsoft.PolicyInsights" -FeatureName "policyStateChangeNotifications"

# once feature is registered, re register the provider
Register-AzResourceProvider -ProviderNamespace "Microsoft.PolicyInsights"

# Obtain a token for PostMan Auth to ARM
ARMClient token

# Pivot and do this in Postman for tracking async operation of Event Topic creation
$armcall2 = "/subscriptions/" + $SubId + "/resourceGroups/" + $rgname + "/providers/Microsoft.EventGrid/systemTopics/" + $systemTopicName + "/eventSubscriptions/" + $eventSubName + "?api-version=2020-04-01-preview"

armclient PUT $armcall2 "@eventhandler.json"

# Header repsonse will contain Operation Status use this to plug into GET
# https://management.azure.com:443/subscriptions/e2ceb149-f61a-4985-b55e-67326d2592ee/providers/Microsoft.EventGrid/operationsStatus/5174F893-36B2-4345-819F-B03063EDE04E?api-version=2020-04-01-preview