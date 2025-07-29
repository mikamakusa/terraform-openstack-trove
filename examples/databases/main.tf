provider "openstack" {}

module "instance" {
  source = "../../"
  instances = [
    {
      region            = "region-test"
      name              = "test"
      flavor_id         = "31792d21-c355-4587-9290-56c1ed0ca376"
      size              = 8
      datastore_type    = "mysql"
      datastore_version = "mysql-5.7"
      database = [
        {
          name        = "mydb-1"
        },
        {
          name        = "mydb-2"
        }
      ]
    }
  ]
}