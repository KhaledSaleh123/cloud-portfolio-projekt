variable "aws_region" {
  description = "AWS-Region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Projektname, wird fuer Namen und Tags benutzt"
  type        = string
  default     = "cloud-portfolio"
}

variable "environment" {
  description = "Umgebung (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment muss dev, staging oder prod sein."
  }
}

variable "instance_type" {
  description = "EC2-Instanztyp"
  type        = string
  default     = "t2.micro"
}



