
# Create a Resource Group
resource "azurerm_resource_group" "azurergforstaticweb" {
  name     = "it-is-my-new-resources1"  # Name of the resource group
  location = "East US"                  # Location for the resource group
}

# Create a Storage Account with Static Website Hosting Enabled
resource "azurerm_storage_account" "myazurestorage" {
  name                     = "mystorageacctunique54321"  # Unique storage account name
  resource_group_name      = azurerm_resource_group.azurergforstaticweb.name
  location                 = azurerm_resource_group.azurergforstaticweb.location
  account_tier             = "Standard"                   # Account tier
  account_replication_type = "LRS"                        # Replication type

  static_website {
    index_document = "index.html"  # Set the index document for the static website
  }
}

# resource "azurerm_storage_container" "web_container" {
#   name                  = "$web"                       # Use the special container name for static websites
#   storage_account_name  = azurerm_storage_account.myazurestorage.name
#   container_access_type = "private"                    # Set access type to private
# }

# Upload the index.html file to the $web container
resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"                              # Name of the HTML file
  storage_account_name   = azurerm_storage_account.myazurestorage.name
  storage_container_name = "$web"
  type                   = "Block"                                   # Blob type
  source                 = "C:\\Users\\rauta\\OneDrive\\Desktop\\DemoHosting\\index.html"            # Path to your local index.html file
}
