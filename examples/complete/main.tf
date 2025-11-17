data "yandex_client_config" "client" {}


module "iam_accounts" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-iam.git//modules/iam-account?ref=v1.0.0"

  name = "iam"
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

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "spark-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]

  private_subnets = [["10.3.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}


module "spark" {
  source = "../../"

  cluster_name = "production-spark-cluster"
  description  = "Production Spark cluster for data processing"

  service_account_id = module.iam_accounts.id
  subnet_ids         = [module.network.private_subnets_ids[0]]

  driver_resource_preset = "c2-m8"
  driver_size            = 1

  executor_resource_preset = "c4-m16"
  executor_min_size        = 2
  executor_max_size        = 4

  pip_packages = [
    "numpy==2.2.2",
  ]

  logging_enabled = true

  depends_on = [module.iam_accounts, module.network]
}
