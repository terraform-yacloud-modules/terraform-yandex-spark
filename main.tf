data "yandex_client_config" "client" {}

locals {
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  # Cloud Logging writes to either the folder's default log group or an explicit
  # log group, never to both.
  logging_folder_id    = var.logging_enabled && var.logging_log_group_id == null ? local.folder_id : null
  logging_log_group_id = var.logging_enabled ? var.logging_log_group_id : null

  metastore = var.metastore_cluster_id == null ? null : {
    cluster_id = var.metastore_cluster_id
  }

  # The driver pool is either fixed-size or autoscaling, never both.
  driver_autoscaling = var.driver_min_size != null || var.driver_max_size != null
}

resource "yandex_spark_cluster" "my_spark_cluster" {
  name                = var.cluster_name
  description         = var.description
  folder_id           = var.folder_id
  labels              = var.labels
  service_account_id  = var.service_account_id
  deletion_protection = var.deletion_protection

  config = {
    resource_pools = {
      driver = {
        resource_preset_id = var.driver_resource_preset
        size               = local.driver_autoscaling ? null : var.driver_size
        min_size           = local.driver_autoscaling ? var.driver_min_size : null
        max_size           = local.driver_autoscaling ? var.driver_max_size : null
      }
      executor = {
        resource_preset_id = var.executor_resource_preset
        min_size           = var.executor_min_size
        max_size           = var.executor_max_size
        preemptible        = var.executor_preemptible
      }
    }
    dependencies = {
      pip_packages = var.pip_packages
      deb_packages = var.deb_packages
    }
    history_server = {
      enabled = var.history_server_enabled
    }
    metastore     = local.metastore
    spark_version = var.spark_version
  }

  network = {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  logging = {
    enabled      = var.logging_enabled
    folder_id    = local.logging_folder_id
    log_group_id = local.logging_log_group_id
  }

  maintenance_window = var.maintenance_window

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    precondition {
      condition     = (var.driver_min_size == null) == (var.driver_max_size == null)
      error_message = "driver_min_size and driver_max_size must be set together."
    }

    precondition {
      condition     = local.driver_autoscaling ? var.driver_min_size <= var.driver_max_size : true
      error_message = "driver_min_size must be less than or equal to driver_max_size."
    }
  }
}
