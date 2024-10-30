# Create a Resource Group
resource "azurerm_resource_group" "azurergforstaticweb" {
  name     = "it-is-my-new-resources-ii"  # Name of the resource group
  location = "East US"                    # Location for the resource group
}

# Create a Storage Account with Static Website Hosting Enabled
resource "azurerm_storage_account" "myazurestorage" {
  name                     = "mystorageacctunique09"  # Unique storage account name
  resource_group_name      = azurerm_resource_group.azurergforstaticweb.name
  location                 = azurerm_resource_group.azurergforstaticweb.location
  account_tier             = "Standard"               # Account tier
  account_replication_type = "LRS"                    # Replication type

  static_website {
    index_document = "index.html"  # Set the index document for the static website
  }
}

# Create a Local Index HTML File
resource "local_file" "index_html_file" {
  filename = "${path.module}/index.html"
  content  = "<html><body><h1>Welcome to My Static Website!</h1></body></html>"
}

# Upload the HTML File to the Static Website Container
resource "azurerm_storage_blob" "index_html" {
  depends_on             = [local_file.index_html_file]
  name                   = "index.html"  # File name in the container
  storage_account_name   = azurerm_storage_account.myazurestorage.name
  storage_container_name = "$web"        # Directly upload to the $web container for static website
  type                   = "Block"
  source                 = local_file.index_html_file.filename  # Path to the local file created
}
