variable "db_identifier" {
  description = "The RDS database identifier."
  type        = string
  default     = "mydb-instance"
}

variable "db_username" {
  description = "The RDS database username."
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The RDS database password."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the RDS database."
  type        = string
  default     = "mydatabase"
}

variable "security_group_ids" {
  description = "Security group IDs to attach to the RDS instance."
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS instance."
  type        = list(string)
}

