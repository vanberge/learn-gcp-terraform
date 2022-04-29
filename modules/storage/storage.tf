resource "google_storage_bucket" "gcs_bucket" {
  name                        = var.project_id  #name the bucket the same thing as the project
  location                    = "US"
  storage_class               = "Standard"
  uniform_bucket_level_access = true
}