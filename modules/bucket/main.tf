module "bucket_name" {
  source            = "../string_formatter"
  name              = var.name
  add_random_suffix =  var.add_random_suffix
}


resource "google_storage_bucket" "test_bucket" {
  project       = var.project
  name          = module.bucket_name.result
  location      = upper(var.location)
  force_destroy = var.force_destroy
  uniform_bucket_level_access = true

  dynamic "custom_placement_config" {
    for_each = length(var.dual_region_locations) != 0 ? [1] : []
    content {
      data_locations = var.dual_region_locations
    }
    
  }

}

resource "google_storage_notification" "bucket_notification" {
  bucket         = google_storage_bucket.test_bucket.name
  payload_format = "JSON_API_V1"
  topic          = "//pubsub.googleapis.com/projects/temporal-field-419719/topics/default-notification-topic"
}


/*
resource "google_storage_bucket_iam_binding" "binding" {
  bucket  = google_storage_bucket.test_bucket.name
  role    = "roles/storage.admin"
  members = var.members
  
  condition {
    title       = "expires_after_2019_12_31"
    description = "Expiring at midnight of 2019-12-31"
    expression  = "request.time < timestamp(\"2020-01-01T00:00:00Z\")"
  }
}


resource "google_project_iam_member" "pubsub_publisher" {
  project = var.project
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-287505208604@gs-project-accounts.iam.gserviceaccount.com"
}


resource "google_storage_notification" "notifications" {
  for_each = {
    for n in var.notifications:
      base64encode(jsonencode(n)) => n
  }

  bucket = google_storage_bucket.test_bucket.name
  payload_format = each.value.payload_format
  topic = each.value.topic
  event_types = each.value.event_types
  custom_attributes = each.value.custom_attributes
  object_name_prefix = each.value.object_name_prefix
}
*/
