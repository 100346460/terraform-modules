provider "google" {
  project = "temporal-field-419719"
}

variables {
    name     = "test_bucket_23451234"
    location = "US"
    project  = "temporal-field-419719"
    dual_region_locations = ["us-central1", "us-east4"] 
    members = [
        "user:daniel.lufthansa.gcp2@gmail.com"
        ]

    notifications = [{
        topic = "default-notification-topic"
    }]

}



run "test_bucket_created_with_random_4_character_suffix" {
    command = apply

    module {
        source = "./modules/bucket"
    }


    assert {
        
        condition = can(regex("-[a-z]{4}$", output.name)) 
        error_message =  "variable name does not equal output name"
    }
}




run "test_failure_when_1_dual_region_passed" {
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

run "test_base_url_is_correct_format" {
    command = apply

     module {
        source = "./modules/bucket"
    }

    assert {
        
        condition = can(regex("^gs://${output.name}", output.url))
        error_message =  "output url not as expected"
    }

}

/*
run "test_notification_id_is_outputted" {
    command = apply

     module {
        source = "./modules/bucket"
    }

    assert {
        
        condition =  output.notifications == [topic-notification-default]
        error_message =  "output url not as expected"
    }

}

gcloud projects add-iam-policy-binding temporal-field-419719 \
  --role roles/pubsub.publisher \
  --member serviceAccount:service-287505208604@gs-project-accounts.iam.gserviceaccount.com

  gcloud projects add-iam-policy-binding temporal-field-419719 \
  --role roles/storage.admin \
  --member serviceAccount:service-287505208604@gs-project-accounts.iam.gserviceaccount.com


gcloud projects add-iam-policy-binding temporal-field-419719 \
--role roles/storage.admin \
--member user:daniel.lufthansa.gcp2@gmail.com


*/