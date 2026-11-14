output "spark_cluster_id" {
  description = "Spark cluster ID"
  value       = module.spark.id
}

output "spark_cluster_name" {
  description = "Spark cluster name"
  value       = module.spark.name
}

output "spark_cluster_status" {
  description = "Spark cluster status"
  value       = module.spark.status
}

output "spark_cluster_version" {
  description = "Apache Spark version of the cluster"
  value       = module.spark.spark_version
}
