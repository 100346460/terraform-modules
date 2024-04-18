output "name" {
    value = google_storage_bucket.test_bucket.name
}

output "location" {
    value = google_storage_bucket.test_bucket.location
}

output "url" {
    description = "The base url of the bucket, in the format gs://<bucket-name>"
    value = google_storage_bucket.test_bucket.url
}

/*
output "notifications" {
    description = "The list of Storage Notifcations on the bucket"
    value = [for n in google_storage_notification.notifications: n.notification_id]
}
*/
