variable "project" {}

variable "name" {}

variable "location" {}

variable "add_random_suffix" {
    type = bool
    default = true
}

variable "dual_region_locations" {
    type = list(string)
    default = []

    validation {
        condition = length(var.dual_region_locations) == 0 || length(var.dual_region_locations) == 2
        error_message = "Exactly 0 or 2 regions expected."
    }
}

variable "force_destroy" {
    default = true
}


variable "members" {
    type = list(string)
    default = []
}

variable "notifications" {
    description = "List of notification configurations for the bucket to send to PubSub/ when updated"
    type = list(object({
        topic              = string
        custom_attributes  = optional(map(string), {})
        event_types        = optional(list(string), ["OBJECT_FINALIZE"])
        payload_format     = optional(string, "JSON_API_V1")
        object_name_prefix = optional(string, null)
    }))
    default = []
}
