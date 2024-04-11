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

  dynamic "custom_placement_config" {
    for_each = length(var.dual_region_locations) != 0 ? [1] : []
    content {
      data_locations = var.dual_region_locations
    }
    
  }

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

