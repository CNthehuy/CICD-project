output "container_name" {
  description = "Name of the deployed Docker container"
  value       = docker_container.flask_app.name
}

output "application_url" {
  description = "URL for the deployed Flask application"
  value       = "http://localhost:${var.external_port}"
}