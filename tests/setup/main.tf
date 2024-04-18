provider "google" {
  project = "temporal-field-419719"
}


module "bucket" {
  source = "../../modules/bucket"
  location = "US"
  name = "test_bucket_with_content"
  project = "temporal-field-419719"

}

resource "local_file" "example_file" {
  filename = "example.txt"
  content  = "This is example content."
}

resource "google_storage_bucket_object" "example_object" {
  name   = "example.txt"
  bucket = module.bucket.name
  source = local_file.example_file.filename
}

resource "google_pubsub_subscription" "storage_subscription" {
  name   = "storage-subscription"
  topic  = "default-notification-topic"
  # Configure the subscription to pull messages
  ack_deadline_seconds = 30  # Adjust as needed
}


output "setup_bucket_name" {
  value = module.bucket.name
}

