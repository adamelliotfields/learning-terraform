output "database_name" {
  value = mysql_database.ghost.name
}

output "database_user" {
  value = mysql_user.ghost.user
}
