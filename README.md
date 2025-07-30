## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | >= 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | >= 3.3.2 |

## Modules

No modules.

## Usage

- [instances](examples/instances/main.tf)
- [databases](examples/databases/main.tf)
- [users](examples/users/main.tf)

## Resources

| Name | Type |
|------|------|
| [openstack_db_configuration_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/db_configuration_v1) | resource |
| [openstack_db_database_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/db_database_v1) | resource |
| [openstack_db_instance_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/db_instance_v1) | resource |
| [openstack_db_user_v1.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/db_user_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configurations"></a> [configurations](#input\_configurations) | n/a | <pre>list(object({<br/>    name        = string<br/>    description = string<br/>    datastore = list(object({<br/>      type    = string<br/>      version = string<br/>    }))<br/>    configuration = list(object({<br/>      name  = string<br/>      value = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | n/a | <pre>list(object({<br/>    name              = string<br/>    size              = number<br/>    volume_type       = string<br/>    region            = optional(string)<br/>    flavor_id         = optional(string)<br/>    configuration_id  = optional(string)<br/>    network_uuid      = optional(string)<br/>    datastore_type    = optional(string)<br/>    datastore_version = optional(string)<br/>    databases = optional(list(object({<br/>      name    = string<br/>      charset = optional(string)<br/>      collate = optional(string)<br/>    })))<br/>    user = optional(list(object({<br/>      name      = string<br/>      password  = string<br/>      databases = optional(set(string))<br/>    })))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration"></a> [configuration](#output\_configuration) | Informations relatives à la configuration. |
| <a name="output_database"></a> [database](#output\_database) | Informations relatives aux bases de données. |
| <a name="output_instance"></a> [instance](#output\_instance) | Informations relatives aux instances de bases de données. |
| <a name="output_user"></a> [user](#output\_user) | Informations relatives aux comptes utilisateurs. |
