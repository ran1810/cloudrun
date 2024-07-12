output "cloud_sql_instance_connection_name" {
  value = google_sql_database_instance.postgres.connection_name
}

output "cloud_run_url" {
  value = google_cloud_run_service.default.status[0].url
}
