# Audit-RoleAssignment
author: Nathan Swift

This Logic App will webhook trigger from a ActivityLog Alert and read the Azure Role Assignment Write activity event and enrich the event with the actual Role Definition, Scope, and AAD Object Details. It will then notify a team.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FAudit-RoleAssignment%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FAudit-RoleAssignment%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

The Logic App creates and uses a Managed System Identity (MSI) to authenticate and authorize against management.azure.com to obtain RoleDefID, Scope, and PrincipalID that recieved Role Assignment. The MSI is also used to authenticate and authorize against graph.windows.net to obtains RBAC Objects by PrincipalIDs.

Assign RBAC 'Reader' role to the Logic App at the MG or Subscription level. Assign AAD Directory Role 'Directory readers' role to the Logic App.

Setup a AzureActivity Alert and point Action Group to this Logic App:
