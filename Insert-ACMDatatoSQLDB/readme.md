# Insert-ACMDatatoSQLDB
author: Nathan Swift

This Logic App will run daily and pull yesterdays Azure Cost Management data and send to a Azure SQL Database.

<a href="https://azuredeploy.net/?repository=https://github.com/swiftsolves-msft/LogicApps/blob/master/Insert-ACMDatatoSQLDB" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fswiftsolves-msft%2FLogicApps%2Fmaster%2FInsert-ACMDatatoSQLDB%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

**Additional Post Install Notes:**

Be sure to go to the Resource Group and authorize the sql web connection to point to your PaaS SQL Server and Database. The logic App is deployed in a disabled state you must enable after authorizing sql web connection.

### SQL Table Creation \ Schema

CREATE TABLE AzureCostManagementTest
(
    "runGuid" NVARCHAR(128) PRIMARY KEY,
       "subscriptionGuid" NVARCHAR(128),
    "serviceName" NVARCHAR(128),
       "serviceTier" NVARCHAR(128),
    "location" NVARCHAR(128),
       "chargesBilledSeparately" NVARCHAR(128),
    "resourceGuid" NVARCHAR(128),
       "offerId" NVARCHAR(128),
    "cost" float,
       "accountId" NVARCHAR(128),
    "productId" NVARCHAR(128),
       "resourceLocationId" NVARCHAR(128),
    "consumedServiceId" NVARCHAR(128),
       "departmentId" NVARCHAR(128),
    "accountOwnerEmail" NVARCHAR(128),
       "accountName" NVARCHAR(128),
    "serviceAdministratorId" NVARCHAR(128),
       "subscriptionId" NVARCHAR(128),
    "subscriptionName" NVARCHAR(128),
       "date" NVARCHAR(128),
    "product" NVARCHAR(128),
       "meterId" NVARCHAR(128),
    "meterCategory" NVARCHAR(128),
       "meterSubCategory" NVARCHAR(128),
    "meterRegion" NVARCHAR(128),
       "meterName" NVARCHAR(128),
       "consumedQuantity" float,
    "resourceRate" float,
       "resourceLocation" NVARCHAR(128),
    "consumedService" NVARCHAR(128),
       "instanceId" NVARCHAR(640),
    "serviceInfo1" NVARCHAR(128),
    "serviceInfo2" NVARCHAR(128),
       "additionalInfo" NVARCHAR(640),
    "tags" NVARCHAR(640),
       "storeServiceIdentifier" NVARCHAR(128),
    "departmentName" NVARCHAR(128),
       "costCenter" NVARCHAR(128),
    "unitOfMeasure" NVARCHAR(128),
       "resourceGroup" NVARCHAR(128)
)

### Delete Table of Data

DELETE FROM dbo.AzureCostManagementTest11;  
GO  

### Check for duplicates of data rows

SELECT [subscriptionGuid]
      ,[serviceName]
      ,[serviceTier]
      ,[location]
      ,[chargesBilledSeparately]
      ,[resourceGuid]
      ,[offerId]
      ,[cost]
      ,[accountId]
      ,[productId]
      ,[resourceLocationId]
      ,[consumedServiceId]
      ,[departmentId]
      ,[accountOwnerEmail]
      ,[accountName]
      ,[serviceAdministratorId]
      ,[subscriptionId]
      ,[subscriptionName]
      ,[date]
      ,[product]
      ,[meterId]
      ,[meterCategory]
      ,[meterSubCategory]
      ,[meterRegion]
      ,[meterName]
      ,[consumedQuantity]
      ,[resourceRate]
      ,[resourceLocation]
      ,[consumedService]
      ,[instanceId]
      ,[serviceInfo1]
      ,[serviceInfo2]
      ,[additionalInfo]
      ,[tags]
      ,[storeServiceIdentifier]
      ,[departmentName]
      ,[costCenter]
      ,[unitOfMeasure]
      ,[resourceGroup]
         ,COUNT(*) occurrences
FROM [dbo].[AzureCostManagementTest11]
GROUP BY
      [subscriptionGuid]
      ,[serviceName]
      ,[serviceTier]
      ,[location]
      ,[chargesBilledSeparately]
      ,[resourceGuid]
      ,[offerId]
      ,[cost]
      ,[accountId]
      ,[productId]
      ,[resourceLocationId]
      ,[consumedServiceId]
      ,[departmentId]
      ,[accountOwnerEmail]
      ,[accountName]
      ,[serviceAdministratorId]
      ,[subscriptionId]
      ,[subscriptionName]
      ,[date]
      ,[product]
      ,[meterId]
      ,[meterCategory]
      ,[meterSubCategory]
      ,[meterRegion]
      ,[meterName]
      ,[consumedQuantity]
      ,[resourceRate]
      ,[resourceLocation]
      ,[consumedService]
      ,[instanceId]
      ,[serviceInfo1]
      ,[serviceInfo2]
      ,[additionalInfo]
      ,[tags]
      ,[storeServiceIdentifier]
      ,[departmentName]
      ,[costCenter]
      ,[unitOfMeasure]
      ,[resourceGroup]
HAVING 
    COUNT(*) > 1;
