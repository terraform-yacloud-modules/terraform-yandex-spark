variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  default     = null
}

variable "service_account_id" {
  description = "Service account ID for Spark cluster"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "Spark cluster name"
  type        = string
  default     = null
}

variable "description" {
  description = "Spark cluster description"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the Spark cluster"
  type        = map(string)
  default     = {}
}

variable "driver_resource_preset" {
  description = "Resource preset ID for Spark driver"
  type        = string
  default     = "c2-m8"
}

variable "driver_size" {
  description = "Number of driver instances"
  type        = number
  default     = 1
}

variable "executor_resource_preset" {
  description = "Resource preset ID for Spark executor"
  type        = string
  default     = "c2-m8"
}

variable "executor_min_size" {
  description = "Minimum number of executor instances"
  type        = number
  default     = 1
}

variable "executor_max_size" {
  description = "Maximum number of executor instances"
  type        = number
  default     = 2
}

variable "executor_preemptible" {
  description = "Run Spark executors on preemptible (interruptible) instances"
  type        = bool
  default     = false
}

variable "history_server_enabled" {
  description = "Enable Spark History Server"
  type        = bool
  default     = true
}

variable "spark_version" {
  description = "Apache Spark version in the format reported by the service, for example \"3.5.7\". If omitted, the service default version is used"
  type        = string
  default     = null
}

variable "metastore_cluster_id" {
  description = "ID of the Yandex Managed Metastore cluster connected to the Spark cluster"
  type        = string
  default     = null
}

variable "pip_packages" {
  description = "List of pip packages to install"
  type        = list(string)
  default     = []
}

variable "deb_packages" {
  description = "List of deb packages to install"
  type        = list(string)
  default     = []
}

variable "logging_enabled" {
  description = "Enable logging for Spark cluster"
  type        = bool
  default     = true
}

variable "logging_log_group_id" {
  description = "Cloud Logging log group ID for Spark cluster logs. When set, logs go to this group instead of the folder's default log group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach the Yandex Spark"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the Spark cluster"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "Protect the Spark cluster from accidental deletion"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Maintenance window configuration. For type = \"WEEKLY\" both day and hour must be set"
  type = object({
    type = string
    day  = optional(string)
    hour = optional(number)
  })
  default = null
}
