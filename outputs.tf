output "id" {
  description = "Spark cluster ID"
  value       = yandex_spark_cluster.my_spark_cluster.id
}

output "name" {
  description = "Spark cluster name"
  value       = yandex_spark_cluster.my_spark_cluster.name
}

output "folder_id" {
  description = "Folder ID the Spark cluster belongs to"
  value       = yandex_spark_cluster.my_spark_cluster.folder_id
}

output "created_at" {
  description = "Spark cluster creation timestamp"
  value       = yandex_spark_cluster.my_spark_cluster.created_at
}

output "status" {
  description = "Spark cluster status"
  value       = yandex_spark_cluster.my_spark_cluster.status
}

output "spark_version" {
  description = "Apache Spark version of the cluster"
  value       = yandex_spark_cluster.my_spark_cluster.config.spark_version
}
