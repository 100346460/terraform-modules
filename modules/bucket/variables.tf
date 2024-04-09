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