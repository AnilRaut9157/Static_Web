output "static_website_url" {
  value = azurerm_storage_account.myazurestorage.primary_web_endpoint
}