resource "openstack_db_instance_v1" "this" {
  for_each         = { for instance in var.instances : instance.name => instance }
  name             = each.value.name
  size             = each.value.size
  region           = each.value.region
  flavor_id        = each.value.flavor_id
  configuration_id = each.value.configuration_id

  dynamic "network" {
    for_each = { for instance in var.instances : instance.name => instance if contains(keys(instance), "network_uuid") }
    content {
      uuid = each.value.network_uuid
    }
  }

  dynamic "datastore" {
    for_each = { for instance in var.instances : instance.name => instance if contains(keys(instance), "datastore_type") && contains(keys(instance), "datastore_version") }
    content {
      type    = each.value.datastore_type
      version = each.value.datastore_version
    }
  }

  dynamic "database" {
    for_each = { for instance in var.instances.*.databases : instance.name => instance if contains(keys(instance), "charset") && contains(keys(instance), "collate") }
    content {
      name    = lookup(each.value, "name")
      charset = lookup(each.value, "charset")
      collate = lookup(each.value, "collate")
    }
  }
}

resource "openstack_db_database_v1" "this" {
  for_each    = { for instance in var.instances : instance.name => instance if contains(keys(instance), "databases") && instance.databases != null }
  instance_id = openstack_db_instance_v1.this[each.key].id
  name        = lookup(each.value, "name")
  region      = openstack_db_instance_v1.this[each.key].region
}

resource "openstack_db_configuration_v1" "this" {
  for_each    = { for conf in var.configurations : conf.name => conf }
  description = each.value.description
  name        = each.value.name

  dynamic "datastore" {
    for_each = { for conf in var.configurations : conf.name => conf if contains(keys(conf), "datastore") }
    content {
      type    = lookup(each.value, "type")
      version = lookup(each.value, "version")
    }
  }

  dynamic "configuration" {
    for_each = { for conf in var.configurations : conf.name => conf if contains(keys(conf), "configuration") }
    content {
      name  = lookup(each.value, "name")
      value = lookup(each.value, "value")
    }
  }
}

resource "openstack_db_user_v1" "this" {
  for_each    = { for instance in var.instances : instance.name => instance if contains(keys(instance), "user") && instance.user != null }
  instance_id = openstack_db_instance_v1.this[each.key].id
  name        = lookup(each.value, "name")
  password    = sensitive(lookup(each.value, "password"))
  region      = openstack_db_instance_v1.this[each.key].region
  databases   = lookup(each.value, "databases")
}