# Terraform Provisioning on Azure with AzureDevops CICD
This repo shows how Terraform can be used to provision infrastructure on Azure cloud and how automation can be done using Azure DevOps CiCd declarative file that contain various steps involved in validation and deployment on cloud
# Approach
<ul>
  <li>generate keys imperatively</li>
  <li>Use terraform.tf file provision infrastructure on Azure</li>
  <li>Create declarative CICD pipeline that contains validation and deployment stages</li>
</ul>

## Generate required keys
#### 
create a resource group on azure
```
az group create -l westus -n terraform-test
``` 
#### create service principle to connect azure cloud to Azure DevOps
```
az ad sp create-for-rbac -n terraform-test --role contributor --scopes <azure resource group id>
``` 
#### 
Goto Azure DevOps to create service connection in the azure resource manager and use the service principle already created and authenticat 

create a blob storage for Terraform state file
```
az storage account create --resource-group terraform-test --name test-account --sku standard_LRS --encryption-service blob
``` 
#### get the key
```
az storage account keys list --resource-group terraform-test --account-name test-account
``` 

#### get the value of the key and create a container within the blob
```
az storage container create --name test-container --account-name test-account --account-key <paste account key>
``` 
