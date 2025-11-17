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

variable "zone_id" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "cluster_name" {
  description = "Spark cluster name"
  type        = string
  default     = "minimal-spark-cluster"
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
  default     = "c4-m16"
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
  default     = ["numpy==2.2.2"]
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