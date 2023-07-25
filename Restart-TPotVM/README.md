# Restart-TPotVM

author: Nathan Swift

This Logic App can be striggered whn a avalibility test fails to access Azure T-Pot VM's Cockpit service. The LogicApp will the deallocate T-Pot VM and wait and then start the T-Pot VM. There have been cases where the linux waagent fails to communicate and the TPot service and Honeypots becom unavaliable, a restart can usually solve this.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FRestart-TPotVM%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FRestart-TPotVM%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

**Additional Post Install Notes:**

The Logic App creates and uses a Managed System Identity (MSI) to authenticate and authorize against management.azure.com to deallocate and start a Azure VM running T-Pot.

Assign RBAC 'Virtual Machine Contributor' role to the Logic App at the MG or Subscription level.