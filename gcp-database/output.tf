output "database_name" {
  description = "The name of the DB instance"
  value = google_sql_database_instance.default.name
}

output "database_version" {
  description = "Database version"
  value       = google_sql_database_instance.default.database_version
}

output "postgres_user_password" {
  description = "Postgres user password"
  value       = google_sql_user.default.password
}
