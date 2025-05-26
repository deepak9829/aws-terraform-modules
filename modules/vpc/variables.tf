variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones for the subnets"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
