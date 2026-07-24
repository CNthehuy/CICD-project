variable "image_name" {
  description = "Name of the Docker image used by the Flask container"
  type        = string
  default     = "class-proj-app:latest"
}

variable "container_name" {
  description = "Name of the deployed Flask container"
  type        = string
  default     = "flask-app-container"
}

variable "external_port" {
  description = "Port exposed on the host machine"
  type        = number
  default     = 5000
}

variable "internal_port" {
  description = "Port Flask listens on inside the container"
  type        = number
  default     = 5000
}