module "bucket_name" {
  source            = "../string_formatter"
  name              = var.name
  add_random_suffix =  var.add_random_suffix
}


resource "google_storage_bucket" "test_bucket" {
  project       = var.project
  name          = module.bucket_name.result
  location      = var.location
  force_destroy = true

  dynamic "custom_placement_config" {
    for_each = length(var.dual_region_locations) != 0 ? [1] : []
    content {
      data_locations = var.dual_region_locations
    }
    
  }

}

