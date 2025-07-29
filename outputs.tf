output "instance" {
  description = "Informations relatives aux instances de bases de données."
  value = {
    for a in openstack_db_instance_v1.this : a => {
      id               = a.id
      name             = a.name
      region           = a.region
      name             = a.name
      size             = a.size
      flavor_id        = a.flavor_id
      configuration_id = a.configuration_id
      datastore        = a.datastore
      network          = a.network
      database         = a.database
      user             = a.user
    }
  }
}

output "database" {
  description = "Informations relatives aux bases de données."
  value = {
    for a in openstack_db_database_v1.this : a => {
      id          = a.id
      name        = a.name
      region      = a.region
      instance_id = a.instance_id
    }
  }
}

output "configuration" {
  description = "Informations relatives à la configuration."
  value = {
    for a in openstack_db_configuration_v1.this : a => {
      id            = a.id
      name          = a.name
      region        = a.region
      description   = a.description
      datastore     = a.datastore
      configuration = a.configuration
    }
  }
}

output "user" {
  description = "Informations relatives aux comptes utilisateurs."
  value = {
    for a in openstack_db_user_v1.this : a => {
      id          = a.id
      name        = a.name
      instance_id = a.instance_id
      databases   = a.databases
      password    = sensitive(a.password)
    }
  }
}