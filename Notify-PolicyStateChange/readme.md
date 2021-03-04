# Notify-PolicyStateChange
author: Nathan Swift

## ! Warning Experimental

This Logic App will trigger from a Azure resource policy health state change via eventgrid topic. Logic App will look up Azure Resource ActivityLog and Permissions and send an email accordingly with policy state change and infoirmation around the Azure Resource.

To use see Private Preview Notes on compliance state change notification via Event Grid

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FNotify-PolicyStateChange%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FNotify-PolicyStateChange%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

The Logic App creates and uses a Managed System Identity (MSI) to authenticate and authorize against management.azure.com to obtain RoleDefID, Scope, and PrincipalID that recieved Role Assignment. The MSI is also used to authenticate and authorize against graph.windows.net to obtains RBAC Objects by PrincipalIDs.

Assign RBAC 'Reader' role to the Logic App at the MG or Subscription level. Assign AAD Directory Role 'Directory readers' role to the Logic App.