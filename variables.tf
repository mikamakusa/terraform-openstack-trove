variable "instances" {
  type = list(object({
    name              = string
    size              = number
    volume_type       = string
    region            = optional(string)
    flavor_id         = optional(string)
    configuration_id  = optional(string)
    network_uuid      = optional(string)
    datastore_type    = optional(string)
    datastore_version = optional(string)
    databases = optional(list(object({
      name    = string
      charset = optional(string)
      collate = optional(string)
    })))
    user = optional(list(object({
      name      = string
      password  = string
      databases = optional(set(string))
    })))
  }))
}

variable "configurations" {
  type = list(object({
    name        = string
    description = string
    datastore = list(object({
      type    = string
      version = string
    }))
    configuration = list(object({
      name  = string
      value = string
    }))
  }))
  default = []
}