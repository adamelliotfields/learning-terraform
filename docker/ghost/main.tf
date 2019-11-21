data "docker_registry_image" "ghost" {
  name = "ghost:${var.ghost_tag}"
}

resource "docker_image" "ghost" {
  name = data.docker_registry_image.ghost.name
  keep_locally = true
}

resource "docker_volume" "ghost" {
  name = "ghost"
}

resource "docker_container" "ghost" {
  name = "ghost"
  image = docker_image.ghost.name
  env = [
    "url=http://localhost:8080",
    "database__client=mysql",
    "database__connection__host=mysql",
    "database__connection__port=3306",
    "database__connection__database=${var.database_name}",
    "database__connection__user=${var.database_user}",
    "database__connection__password=${var.database_password_ghost}"
  ]
  volumes {
    volume_name = docker_volume.ghost.name
    container_path = "/var/lib/ghost/content"
  }
  networks_advanced {
    name = var.network_id
  }
  ports {
    internal = 2368
    external = 8080
  }
}
