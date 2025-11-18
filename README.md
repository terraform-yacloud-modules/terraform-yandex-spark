# Yandex Cloud <RESOURCE> Terraform module

Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_spark_cluster.my_spark_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/spark_cluster) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Spark cluster name | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Spark cluster description | `string` | `null` | no |
| <a name="input_driver_resource_preset"></a> [driver\_resource\_preset](#input\_driver\_resource\_preset) | Resource preset ID for Spark driver | `string` | `"c2-m8"` | no |
| <a name="input_driver_size"></a> [driver\_size](#input\_driver\_size) | Number of driver instances | `number` | `1` | no |
| <a name="input_executor_max_size"></a> [executor\_max\_size](#input\_executor\_max\_size) | Maximum number of executor instances | `number` | `2` | no |
| <a name="input_executor_min_size"></a> [executor\_min\_size](#input\_executor\_min\_size) | Minimum number of executor instances | `number` | `1` | no |
| <a name="input_executor_resource_preset"></a> [executor\_resource\_preset](#input\_executor\_resource\_preset) | Resource preset ID for Spark executor | `string` | `"c2-m8"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex Cloud Folder ID | `string` | `null` | no |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | Enable logging for Spark cluster | `bool` | `true` | no |
| <a name="input_pip_packages"></a> [pip\_packages](#input\_pip\_packages) | List of pip packages to install | `list(string)` | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Service account ID for Spark cluster | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs to attach the Yandex Spark | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
