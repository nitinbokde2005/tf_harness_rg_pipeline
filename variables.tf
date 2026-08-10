variable "preprod_resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
  description = "Map of preprod resource groups."
}

variable "prod_resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
  description = "Map of prod resource groups."
}
