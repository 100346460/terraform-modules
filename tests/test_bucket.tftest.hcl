variables {
    name     = "test_bucket_23451234"
    location = "US"
    project  = "temporal-field-419719"
    dual_region_locations = ["us-central1", "us-east4"]
}

run "test_bucket_generates_correct_outputs" {
    command = apply

    module {
        source = "./modules/bucket"
    }

    assert {
        
        condition = can(regex("-[a-z]{4}$", output.name)) 
        error_message =  "variable name does not equal output name"
    }
}


run "test_raises_failure_when_1_dual_region_passed" {
    variables {
    name     = "test_bad_bucket"
    location = "US"
    project  = "temporal-field-419719"
    dual_region_locations = ["us-central1"]
    }

    module {
        source = "./modules/bucket"
    }

    command = plan

    expect_failures = [var.dual_region_locations]

}
