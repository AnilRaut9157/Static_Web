resource "azurerm_resource_group" "myresourcegroupnew" {
  name     = "my-resource-demo-new"
  location = "East US"
}

resource "azurerm_storage_account" "mystorageaccountnew" {
  name                     = "newstorageaccountdemo9"
  resource_group_name      = azurerm_resource_group.myresourcegroupnew.name
  location                 = azurerm_resource_group.myresourcegroupnew.location
  account_tier             = "Standard"
  account_replication_type  = "LRS"
}

resource "azurerm_storage_container" "web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.mystorageaccountnew.name
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.mystorageaccountnew.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = "C:/Users/rauta/OneDrive/Desktop/DemoHosting/index.html"
}
