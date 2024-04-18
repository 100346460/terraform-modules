provider "google" {
  project = "temporal-field-419719"
}

variables {
    topic_name = "test-pubsub-topic-name"
    project = "temporal-field-419719"
    message_retention_duration = "86000s"
}


run "test_pubsub_topic_created" {
  command = apply
  
  module {
        source = "./modules/pubsub"
    }

  assert {
    condition = output.name == var.topic_name
    error_message = "topic name is not correct for pubsub topic"
  }

}