resource "azurerm_resource_group" "myresourcegroup" {
  name     = "my-resource-demo-new"  # Updated name of your resource group
  location = "West US"                # Updated location for your resources
}

resource "azurerm_storage_account" "mystorageaccount" {
  name                     = "uniqueaccountdemo123"  # Updated unique storage account name
  resource_group_name      = azurerm_resource_group.myresourcegroup.name
  location                 = azurerm_resource_group.myresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"   # Set the index document for the static website
  }
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"                # Name of the HTML file
  storage_account_name   = azurerm_storage_account.mystorageaccount.name
  storage_container_name = "$web"                     # Use the special container "$web" for static websites
  type                   = "Block"
  source                 = "D:/HtmlPrograms/index.html" # Path to your local HTML file
}
