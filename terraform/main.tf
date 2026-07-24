resource "docker_container" "flask_app" {
  name  = var.container_name
  image = var.image_name

  restart = "unless-stopped"

  ports {
    internal = var.internal_port
    external = var.external_port
  }
}