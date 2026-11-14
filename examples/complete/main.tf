data "yandex_client_config" "client" {}

provider "yandex" {
}


module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account?ref=v1.0.0"

  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  name = "spark-iam"
  folder_roles = [
    "admin",
  ]
  cloud_roles              = []
  enable_static_access_key = false
  enable_api_key           = false
  enable_account_key       = false

}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  blank_name = "spark-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]

  private_subnets = [["10.3.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

resource "yandex_vpc_security_group" "spark" {
  name       = "spark-cluster-sg"
  network_id = module.network.vpc_id

  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-spark"
  }

  ingress {
    description       = "Spark components talking to each other"
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }

  egress {
    description = "Outgoing traffic for dependencies and Cloud API"
    protocol    = "ANY"
    v4_cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}


module "spark" {
  source = "../../"

  folder_id    = var.folder_id
  cluster_name = "production-spark-cluster"
  description  = "Production Spark cluster for data processing"

  labels = {
    environment = "test"
    repo        = "terraform-yandex-spark"
  }

  service_account_id = module.iam_accounts.id
  subnet_ids         = [module.network.private_subnets_ids[0]]
  security_group_ids = [yandex_vpc_security_group.spark.id]

  driver_resource_preset = "c2-m8"
  driver_size            = 1

  executor_resource_preset = "c4-m16"
  executor_min_size        = 2
  executor_max_size        = 4
  executor_preemptible     = true

  history_server_enabled = false

  spark_version = "3.5.7"

  pip_packages = [
    "numpy==2.2.2",
  ]
  deb_packages = [
    "unzip",
  ]

  maintenance_window = {
    type = "WEEKLY"
    day  = "SUN"
    hour = 12
  }

  deletion_protection = false

  # Cloud Logging is disabled at the cloud level in some environments.
  # Set to true to ship Spark logs to Cloud Logging.
  logging_enabled = false

  depends_on = [module.iam_accounts, module.network]
}
