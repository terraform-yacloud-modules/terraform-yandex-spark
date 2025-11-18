data "yandex_client_config" "client" {}

locals {
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
}

resource "yandex_spark_cluster" "my_spark_cluster" {
  name               = var.cluster_name
  description        = var.description
  service_account_id = var.service_account_id

  config = {
    resource_pools = {
      driver = {
        resource_preset_id = var.driver_resource_preset
        size               = var.driver_size
      }
      executor = {
        resource_preset_id = var.executor_resource_preset
        min_size           = var.executor_min_size
        max_size           = var.executor_max_size
      }
    }
    dependencies = {
      pip_packages = var.pip_packages
    }
  }

  network = {
    subnet_ids = var.subnet_ids
  }

  logging = {
    enabled   = var.logging_enabled
    folder_id = local.folder_id
  }
}
