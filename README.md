# Terraform-модуль Yandex Managed Spark

Модуль создаёт кластер [Yandex Managed Service for Apache Spark](https://yandex.cloud/ru/docs/managed-spark)
и управляет его конфигурацией: пулами драйверов и исполнителей, зависимостями,
Metastore, History Server, журналированием и окном обслуживания.

## Возможности

- Создание кластера Spark в указанном каталоге и подсетях.
- Фиксированный размер пула драйверов (`driver_size`) или автомасштабирование
  (`driver_min_size` и `driver_max_size`).
- Автомасштабирование пула исполнителей и прерываемые (preemptible) инстансы.
- Установка pip- и deb-пакетов.
- Подключение Yandex Managed Metastore.
- Включение и отключение Spark History Server.
- Отправка логов в Cloud Logging: в лог-группу каталога по умолчанию или в
  явно указанную лог-группу.
- Настройка окна обслуживания.
- Защита кластера от случайного удаления.
- Настройка таймаутов операций создания, изменения и удаления.

## Пример использования

```hcl
module "spark" {
  source = "terraform-yacloud-modules/spark/yandex"

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
  # Автомасштабирование пула драйверов.
  # driver_size игнорируется, когда заданы min/max.
  driver_min_size = 1
  driver_max_size = 2

  executor_resource_preset = "c4-m16"
  executor_min_size        = 2
  executor_max_size        = 4
  executor_preemptible     = true

  history_server_enabled = true
  spark_version          = "3.5.7"

  pip_packages = ["numpy==2.2.2"]
  deb_packages = ["unzip"]

  maintenance_window = {
    type = "WEEKLY"
    day  = "SUN"
    hour = 12
  }

  logging_enabled = true

  timeouts = {
    create = "45m"
    update = "45m"
    delete = "30m"
  }
}
```

Полный пример со всеми параметрами находится в каталоге
[`examples/complete`](examples/complete).

## Пул драйверов: фиксированный размер или автомасштабирование

Пул драйверов поддерживает два взаимоисключающих режима:

- фиксированный размер — задаётся только `driver_size`;
- автомасштабирование — задаются `driver_min_size` и `driver_max_size`,
  а `driver_size` не используется.

Параметры `driver_min_size` и `driver_max_size` нужно задавать вместе.
Если задан только один из них или минимум больше максимума, модуль завершит
планирование с ошибкой.

## Журналирование

При `logging_enabled = true` логи отправляются в Cloud Logging. Если задан
`logging_log_group_id`, используется указанная лог-группа, иначе — лог-группа
каталога по умолчанию. Одновременно обе цели не используются.

## Таймауты операций

Параметр `timeouts` принимает длительности в формате Go, например `30m` или
`1h30m`:

- `create` — таймаут создания кластера;
- `update` — таймаут изменения кластера;
- `delete` — таймаут удаления кластера.

Если параметр не задан, используются значения провайдера по умолчанию.

## Требования

| Название | Версия |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Провайдеры

| Название | Версия |
| ---- | ------- |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Ресурсы

| Название | Тип |
| ---- | ---- |
| [yandex_spark_cluster.my_spark_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/spark_cluster) | ресурс |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | источник данных |

## Входные параметры

| Название | Описание | Тип | По умолчанию | Обязательный |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Имя кластера Spark | `string` | `null` | нет |
| <a name="input_deb_packages"></a> [deb\_packages](#input\_deb\_packages) | Список deb-пакетов для установки | `list(string)` | `[]` | нет |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Защита кластера Spark от случайного удаления | `bool` | `false` | нет |
| <a name="input_description"></a> [description](#input\_description) | Описание кластера Spark | `string` | `null` | нет |
| <a name="input_driver_max_size"></a> [driver\_max\_size](#input\_driver\_max\_size) | Максимальное число драйверов при автомасштабировании. Задаётся вместе с `driver_min_size` | `number` | `null` | нет |
| <a name="input_driver_min_size"></a> [driver\_min\_size](#input\_driver\_min\_size) | Минимальное число драйверов при автомасштабировании. Задаётся вместе с `driver_max_size` | `number` | `null` | нет |
| <a name="input_driver_resource_preset"></a> [driver\_resource\_preset](#input\_driver\_resource\_preset) | ID ресурсного пресета драйвера Spark | `string` | `"c2-m8"` | нет |
| <a name="input_driver_size"></a> [driver\_size](#input\_driver\_size) | Число драйверов при фиксированном размере пула. Игнорируется, если заданы `driver_min_size` и `driver_max_size` | `number` | `1` | нет |
| <a name="input_executor_max_size"></a> [executor\_max\_size](#input\_executor\_max\_size) | Максимальное число исполнителей | `number` | `2` | нет |
| <a name="input_executor_min_size"></a> [executor\_min\_size](#input\_executor\_min\_size) | Минимальное число исполнителей | `number` | `1` | нет |
| <a name="input_executor_preemptible"></a> [executor\_preemptible](#input\_executor\_preemptible) | Запускать исполнителей на прерываемых инстансах | `bool` | `false` | нет |
| <a name="input_executor_resource_preset"></a> [executor\_resource\_preset](#input\_executor\_resource\_preset) | ID ресурсного пресета исполнителя Spark | `string` | `"c2-m8"` | нет |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | ID каталога Yandex Cloud | `string` | `null` | нет |
| <a name="input_history_server_enabled"></a> [history\_server\_enabled](#input\_history\_server\_enabled) | Включить Spark History Server | `bool` | `true` | нет |
| <a name="input_labels"></a> [labels](#input\_labels) | Метки кластера Spark в виде пар ключ/значение | `map(string)` | `{}` | нет |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | Отправлять логи кластера Spark в Cloud Logging | `bool` | `true` | нет |
| <a name="input_logging_log_group_id"></a> [logging\_log\_group\_id](#input\_logging\_log\_group\_id) | ID лог-группы Cloud Logging. Если задан, логи пишутся в неё вместо лог-группы каталога по умолчанию | `string` | `null` | нет |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Окно обслуживания. Для `type = "WEEKLY"` нужно задать `day` и `hour` | <pre>object({<br/>    type = string<br/>    day  = optional(string)<br/>    hour = optional(number)<br/>  })</pre> | `null` | нет |
| <a name="input_metastore_cluster_id"></a> [metastore\_cluster\_id](#input\_metastore\_cluster\_id) | ID кластера Yandex Managed Metastore, подключённого к Spark | `string` | `null` | нет |
| <a name="input_pip_packages"></a> [pip\_packages](#input\_pip\_packages) | Список pip-пакетов для установки | `list(string)` | `[]` | нет |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Список ID групп безопасности, подключённых к кластеру Spark | `list(string)` | `[]` | нет |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | ID сервисного аккаунта для кластера Spark | `string` | `null` | нет |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Версия Apache Spark в формате, который возвращает сервис, например `"3.5.7"`. Если не задана, используется версия по умолчанию | `string` | `null` | нет |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Список ID подсетей для кластера Spark | `list(string)` | n/a | да |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Таймауты операций с кластером. Значения — строки длительности, например `"30m"` или `"1h"` | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | нет |

## Выходные параметры

| Название | Описание |
| ---- | ----------- |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Время создания кластера Spark |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | ID каталога, которому принадлежит кластер Spark |
| <a name="output_id"></a> [id](#output\_id) | ID кластера Spark |
| <a name="output_name"></a> [name](#output\_name) | Имя кластера Spark |
| <a name="output_spark_version"></a> [spark\_version](#output\_spark\_version) | Версия Apache Spark в кластере |
| <a name="output_status"></a> [status](#output\_status) | Статус кластера Spark |

## Лицензия

Apache-2.0. См. [LICENSE](LICENSE).
