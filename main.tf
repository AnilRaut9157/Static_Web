# provider "azurerm" {
#   features {}
# }

# Fetch the index.html file from a GitHub repository
data "http" "index_html" {
  url = "https://github.com/AnilRaut9157/DemoHosting.git/main/index.html"  # Update with your GitHub repo URL
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "mynewstorageaccount" {
  name                     = "examplestoracc"  # Must be globally unique
  resource_group_name      = azurerm_resource_group.myresourcegroup.name
  location                 = azurerm_resource_group.myresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"   # Set the index document for the static website
    # error_document = "404.html"      # Set the error document for the static website (optional)
  }
}

resource "azurerm_storage_container" "web" {
  name                  = "$web"  # Use the special container for static websites
  storage_account_name  = azurerm_storage_account.mynewstorageaccount.name
  container_access_type = "private" # You may set this to 'public' if desired
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"                     # Name of the HTML file
  storage_account_name   = azurerm_storage_account.mynewstorageaccount.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source_content         = data.http.index_html.body
}

# resource "azurerm_storage_blob" "error_html" {
#   name                   = "404.html"                     # Name of the error HTML file
#   storage_account_name   = azurerm_storage_account.example.name
#   storage_container_name = azurerm_storage_container.web.name
#   type                   = "Block"
#   source                 = "C:/path/to/your/local/404.html"  # Update with the path to your local error HTML file
# }

output "static_website_url" {
  value = azurerm_storage_account.mynewstorageaccount.primary_web_endpoint  # Output the static website URL
}
