output "static_website_url" {
  value = azurerm_storage_account.mynewstorageaccount.primary_web_endpoint # Use primary_web_endpoint for static website
}
