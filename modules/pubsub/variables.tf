variable "project" {
    description = "Project ID"
    type = string
}

variable "message_retention_duration" {
    description = "Message retention duration"
    default = "86400s"
    type = string
}

variable "topic_name" {
    description = "Topic Name"
    type = string
}

