#
# Global
#
variable "host_name" {
  description = "DNS name to register (Route 53)"
  type        = string
}

variable "ssh_key" {
  description = "SSH key file"
  type        = string
}

#
# Linode (instance)
#
variable "linode_token" {
  description = "Linode API Token"
  type        = string
  default     = "us-west"
}

variable "linode_region" {
  description = "Linode region"
  type        = string
  default     = "us-east"
}

variable "linode_type" {
  description = "Linode instance type"
  type        = string
  default     = "g6-nanode-1"
}

variable "linode_image" {
  description = "Linode Image"
  type        = string
  default     = "linode/debian11"
}

variable "authorized_user" {
  description = "Authorized user"
  type        = string
}

variable "root_password" {
  description = "Root password"
  type        = string
}

#
# AWS (Route 53)
#
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "host_route_53_zone_id" {
  description = "AWS Route 53 Zone ID"
  type        = string
}
