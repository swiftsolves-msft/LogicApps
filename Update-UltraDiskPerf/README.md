# Update-UltraDiskPerf
author: Nathan Swift

This Logic App will run recieve a Ultra Disk Related Metric Alert and Scale up Perf Configuration of the UltraDisk. Can be used to demo or investigate as a concept.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FUpdate-UltraDiskPerf%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FUpdate-UltraDiskPerf%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

**Additional Post Install Notes:**

The Logic App deploys with a Managed System Identity (MSI) to authenticate and authorize against management.azure.com to obtain information and set configuration of UltraDisk. 

Assign RBAC 'Virtual Machine Contributor' role to the Logic App at the Demo Resource Group level where compute and disks are stored

# Demo Notes

### Big thanks to Ned Bellavance's blog that helped demystify AKS and ultraDisk deployment steps<a href="https://nedinthecloud.com/author/nedbellavance/"</a>

## Tested with a AKS cluster using UltraDisks.


1. ### Create AKS cluster

### varibales
*rg="rgAKSUltraDemo"*

*loc="eastus2"*

*clus="ultra-aks"*

*mcrg="MC_${rg}_${clus}_${loc}"*

*az group create --name $rg --location $loc*

### generate the AKS cluster for zones and as a MSI Auth, 
*az aks create --resource-group $rg --name $clus --vm-set-type VirtualMachineScaleSets --load-balancer-sku standard --node-count 1 --zones 1 --node-vm-size Standard_D2s_v3 --enable-managed-identity --kubernetes-version '1.16.7' --enable-addons monitoring --workspace-resource-id '/subscriptions/{YOURSUBIDHERE}/resourcegroups/{YourRGNameHERE}/providers/microsoft.operationalinsights/workspaces/{YourLogAnalyticsNameHERE}'*

2. ### Update the AKS VMSS compute host to enable ultraSSD

*vmss=$(az vmss list --resource-group $mcrg --query [].name -o tsv)*

*az vmss deallocate -g $mcrg -n $vmss*

*az vmss update -g $mcrg -n $vmss --set additionalCapabilities.ultraSSDEnabled=true*

*az vmss start -g $mcrg -n $vmss*

3. ### Connect to aks cluster

*az aks get-credentials --resource-group $rg --name $clus*

4. ### Create custom storage class for dynamic and allow volume expansion

*kubectl apply -f storage-class-ultra.yaml*

5. ### Create PersistVolumeClaim

*kubectl apply -f Azure-pvc-ultra.yaml*

*kubectl get pvc*

### The command should result in pvc Status being bound and not pending

<img src="https://github.com/swiftsolves-msft/LogicApps/blob/master/Update-UltraDiskPerf/images/pvcscreenshot.png"/>

6. ### Create a pod for azure vote image | If you need to troubleshoot try: kubectl describe pod azure-vote-front

*kubectl apply -f azure-vote-ultra.yaml*

7. ### Log into pod

*kubectl exec -it azure-vote-front -- /bin/bash*

8. ### check mounts and install fio and nano | The pod should not have a mount to the Ultra Disk /mnt/Azure

*df*

<img src="https://github.com/swiftsolves-msft/LogicApps/blob/master/Update-UltraDiskPerf/images/mountsscreenshot.png"/>

*apt-get update*

*apt-get install fio*

*apt-get install nano*

*mkdir demo*

*cd demo*

*nano fiowrite.ini*

[global]
size=30g
direct=1
iodepth=256
ioengine=libaio
bs=8k

[writer1]
rw=randwrite
directory=/mnt/Azure
[writer2]
rw=randwrite
directory=/mnt/Azure
[writer3]
rw=randwrite
directory=/mnt/Azure
[writer4]
rw=randwrite
directory=/mnt/Azure

9. ### Create a Metric Alert and Action group:

<img src="https://github.com/swiftsolves-msft/LogicApps/blob/master/Update-UltraDiskPerf/images/alertscreenshot.png"/>

10. ### run fio | SEE: https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-benchmarks#maximum-write-iops

*fio --runtime 1200 fiowrite.ini*

11. ### Wait about 30 minutes and check back to Azure Monitor Mertics for the Ultra Disk

<img src="https://github.com/swiftsolves-msft/LogicApps/blob/master/Update-UltraDiskPerf/images/metricscreenshot.png"/>

# LINKS

https://nedinthecloud.com/2019/09/02/using-ultra-ssd-storage-with-azure-kubernetes-service/

https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-dynamic-thresholds # Must build Demo 3 days out, for dynamic alerts.
