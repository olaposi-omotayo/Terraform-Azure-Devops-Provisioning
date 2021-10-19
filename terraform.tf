provider "azurerm" {
    version = 'latest'
    features {}
}
terraform {
    Backend "azurerm" { "tstate"
        resource_group_name = 'terraform-test'
        storage_account_name = 'testaccount'
        container_name = 'terraform.tstate'
    }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resourcegroup" {
    name = 'sk-terraform-test'
    location = 'west-us'

}
resource "azure_app_service_plan" "serviceplan" {
    name = 'terraform-sp'
    location = azurerm_resource_group.resourcegroup.location
    resource_group_name = azurerm_resource_group.resourcegroup.name
    sku {
        tier = 'standard'
        size = 'S1'
    }
}
resource "azurerm_app_service" "appservice" {
    name = 'terraform-app-service'
    location = azurerm_resource_group.resourcegroup.location
    resource_group_name = azurerm_resource_group.resourcegroup.name
    app_service_plan_id = azure_app_service_plan.serviceplan.app_service_plan_id
}