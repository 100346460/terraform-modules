resource "google_pubsub_topic" "pubsub_topic" {
    name = var.topic_name
    project = var.project
    message_retention_duration = var.message_retention_duration
}