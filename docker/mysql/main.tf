data "docker_registry_image" "mysql" {
  name = "mysql:${var.mysql_tag}"
}

resource "docker_image" "mysql" {
  name = data.docker_registry_image.mysql.name
  keep_locally = true
}

resource "docker_volume" "mysql" {
  name = "mysql"
}

resource "docker_container" "mysql" {
  name = "mysql"
  image = docker_image.mysql.name
  command = ["--default-authentication-plugin=mysql_native_password"]
  env = [
    "MYSQL_ROOT_HOST=%",
    "MYSQL_ROOT_PASSWORD=${var.database_password_root}"
  ]
  volumes {
    volume_name = "mysql"
    container_path = "/var/lib/mysql"
  }
  networks_advanced {
    name = var.network_id
  }
  ports {
    internal = 3306
    external = 3306
  }
}

resource "mysql_database" "ghost" {
  name = "ghost"
  depends_on = [docker_container.mysql]
}

resource "mysql_user" "ghost" {
  user = "ghost"
  host = "%"
  plaintext_password = var.database_password_ghost
  depends_on = [docker_container.mysql]
}

resource "mysql_grant" "ghost" {
  user = mysql_user.ghost.user
  host = mysql_user.ghost.host
  database = mysql_database.ghost.name
  privileges = ["ALL"]
}
