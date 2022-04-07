resource "google_storage_bucket" "gcs_bucket" {
  name                        = var.project_id
  location                    = "US"
  storage_class               = "Standard"
  uniform_bucket_level_access = true
}