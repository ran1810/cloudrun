variable "project_id" {
  description = "The ID of the project in which to provision resources."
  default     = "qwiklabs-gcp-04-819502c38813"
}

variable "region" {
  description = "The region in which to provision resources."
  default     = "us-west1"
}

variable "db_password" {
  description = "The password for the PostgreSQL database"
  type        = string
  sensitive   = true
}
