
module "bucket" {
  source = "./modules/bucket"

  name     = "test_bucket_4567"
  location = "US"
  project  = "temporal-field-419719"

}


