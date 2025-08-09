variable "db_password" {
  description = "Database password (in prod, retrieved from Vault)"
  type        = string
  sensitive   = true
}
