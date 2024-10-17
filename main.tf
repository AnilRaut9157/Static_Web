resource "azurerm_resource_group" "myresourcegroup" {
  name     = "my-new-resource-group"  # Updated name of your resource group
  location = "West US"                # Updated location for your resources
}

resource "azurerm_storage_account" "mynewstorageaccount" {
  name                     = "uniqueaccountdemo123"  # Updated unique storage account name
  resource_group_name      = azurerm_resource_group.myresourcegroup.name
  location                 = azurerm_resource_group.myresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"   # Set the index document for the static website
  }
}

# Explicitly create the $web container for the static website
resource "azurerm_storage_container" "web_container" {
  name                  = "$web"  # Special container for static website hosting
  storage_account_name  = azurerm_storage_account.mynewstorageaccount.name
  container_access_type = "blob"  # Blob access type to allow public access to the static website files
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"                              # Name of the HTML file
  storage_account_name   = azurerm_storage_account.mynewstorageaccount.name
  storage_container_name = azurerm_storage_container.web_container.name
  type                   = "Block"
  source                 = "C:\\Users\\rauta\\OneDrive\\Desktop\\DemoHosting\\index.html"              # Path to your local HTML file
}


