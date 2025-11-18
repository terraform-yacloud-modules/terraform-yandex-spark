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
  default     = "created by terraform"
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

variable "pip_packages" {
  description = "List of pip packages to install"
  type        = list(string)
  default     = []
}

variable "logging_enabled" {
  description = "Enable logging for Spark cluster"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach the Yandex Spark"
  type        = list(string)
}
