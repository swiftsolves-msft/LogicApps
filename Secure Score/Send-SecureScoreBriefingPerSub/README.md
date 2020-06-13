# Send-SecureScoreBriefingPerSub
author: Nathan Swift

This playbook will send a weekly Security Score briefing per each subscription to the Compliance and Security teams and Subscription Owners and Contributors to help track progress on Secure Score for each Subscription.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FSecure%2520Score%2FSend-SecureScoreBriefingPerSub%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton""/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FAzure-Security-Center%2Fmaster%2FSecure%2520Score%2FSend-SecureScoreBriefingPerSub%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

**Additional Post Install Notes:**

Ensure you have deployed the Get-SecureScoreData Logic App first. Best to let the Get-SecureScoreData run a few days to build historical data. Logic App Get-SecureScoreData will deploy a unique Log Analytics Workspace. When deploying this Logic App be sure to use that workspace. Be sure to authorize the API connections created.

The Logic App creates and uses a Managed System Identity (MSI) to authenticate and authorize against management.azure.com to obtain PrincipalIDs assigned to the Azure Resource. The MSI is also used to authenticate and authorize against graph.windows.net to obtains RBAC Objects by PrincipalIDs.

Assign RBAC 'Reader' role to the Logic App at the Subscription level. Assign AAD Directory Role 'Directory readers' role to the Logic App.