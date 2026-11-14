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
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [yandex_spark_cluster.my_spark_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/spark_cluster) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Spark cluster name | `string` | `null` | no |
| <a name="input_deb_packages"></a> [deb\_packages](#input\_deb\_packages) | List of deb packages to install | `list(string)` | `[]` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Protect the Spark cluster from accidental deletion | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Spark cluster description | `string` | `null` | no |
| <a name="input_driver_resource_preset"></a> [driver\_resource\_preset](#input\_driver\_resource\_preset) | Resource preset ID for Spark driver | `string` | `"c2-m8"` | no |
| <a name="input_driver_size"></a> [driver\_size](#input\_driver\_size) | Number of driver instances | `number` | `1` | no |
| <a name="input_executor_max_size"></a> [executor\_max\_size](#input\_executor\_max\_size) | Maximum number of executor instances | `number` | `2` | no |
| <a name="input_executor_min_size"></a> [executor\_min\_size](#input\_executor\_min\_size) | Minimum number of executor instances | `number` | `1` | no |
| <a name="input_executor_preemptible"></a> [executor\_preemptible](#input\_executor\_preemptible) | Run Spark executors on preemptible (interruptible) instances | `bool` | `false` | no |
| <a name="input_executor_resource_preset"></a> [executor\_resource\_preset](#input\_executor\_resource\_preset) | Resource preset ID for Spark executor | `string` | `"c2-m8"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Yandex Cloud Folder ID | `string` | `null` | no |
| <a name="input_history_server_enabled"></a> [history\_server\_enabled](#input\_history\_server\_enabled) | Enable Spark History Server | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Spark cluster | `map(string)` | `{}` | no |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | Enable logging for Spark cluster | `bool` | `true` | no |
| <a name="input_logging_log_group_id"></a> [logging\_log\_group\_id](#input\_logging\_log\_group\_id) | Cloud Logging log group ID for Spark cluster logs. When set, logs go to this group instead of the folder's default log group | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window configuration. For type = "WEEKLY" both day and hour must be set | <pre>object({<br/>    type = string<br/>    day  = optional(string)<br/>    hour = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_metastore_cluster_id"></a> [metastore\_cluster\_id](#input\_metastore\_cluster\_id) | ID of the Yandex Managed Metastore cluster connected to the Spark cluster | `string` | `null` | no |
| <a name="input_pip_packages"></a> [pip\_packages](#input\_pip\_packages) | List of pip packages to install | `list(string)` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to attach to the Spark cluster | `list(string)` | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Service account ID for Spark cluster | `string` | `null` | no |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Apache Spark version in the format reported by the service, for example "3.5.7". If omitted, the service default version is used | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs to attach the Yandex Spark | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Spark cluster creation timestamp |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | Folder ID the Spark cluster belongs to |
| <a name="output_id"></a> [id](#output\_id) | Spark cluster ID |
| <a name="output_name"></a> [name](#output\_name) | Spark cluster name |
| <a name="output_spark_version"></a> [spark\_version](#output\_spark\_version) | Apache Spark version of the cluster |
| <a name="output_status"></a> [status](#output\_status) | Spark cluster status |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
