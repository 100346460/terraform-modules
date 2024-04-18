provider "google" {
  project = "temporal-field-419719"
}


run "setup_tests" {
    module {
        source = "./tests/setup"
    }
}

run "validate_content_in_bucket" {
  command = apply

  variables {
    bucket_name = "${run.setup_tests.setup_bucket_name}"
  }


  assert {
    condition     = var.bucket_name == "test_bucket"
    error_message = "The bucket name is: ${var.bucket_name}"
  }
}

