resource "azurerm_resource_group" "myresourcegroup" {
  name     = "my-resource-demo" # Name of your resource group
  location = "East US"           # Location for your resources
}

resource "azurerm_storage_account" "mystorageaccount" {
  name                     = "itsmystorageaccountdemo9" # Must be globally unique
  resource_group_name      = azurerm_resource_group.myresourcegroup.name
  location                 = azurerm_resource_group.myresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document    = "index.html"   # Set the index document for the static website
  }
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"                # Name of the HTML file
  storage_account_name   = azurerm_storage_account.mystorageaccount.name
  storage_container_name = "$web"                     # Use the special container "$web" for static websites
  type                   = "Block"
  content_type           = "text/html"
  source                 = "C:/Users/rauta/OneDrive/Desktop/hh/index.html" # Path to your local HTML file
}

