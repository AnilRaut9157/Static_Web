
# Create a Resource Group
resource "azurerm_resource_group" "azurergforstaticweb" {
  name     = "it-is-my-new-resources"  # Name of the resource group
  location = "East US"                  # Location for the resource group
}

# Create a Storage Account with Static Website Hosting Enabled
resource "azurerm_storage_account" "myazurestorage" {
  name                     = "mystorageacctunique12345"  # Unique storage account name
  resource_group_name      = azurerm_resource_group.azurergforstaticweb.name
  location                 = azurerm_resource_group.azurergforstaticweb.location
  account_tier             = "Standard"                   # Account tier
  account_replication_type = "LRS"                        # Replication type

  static_website {
    index_document = "index.html"  # Set the index document for the static website
  }
}

# # Output the URL of the static website
# output "static_website_url" {
#   value = azurerm_storage_account.myazurestorage.primary_web_endpoint
# }
