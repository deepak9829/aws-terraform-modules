variable "role_name" {
  type        = string
  description = "Name of the IAM role"
}

variable "assume_role_policy" {
  type        = string
  description = "IAM Assume Role Policy JSON"
}

variable "policy_arn" {
  type        = string
  description = "Policy ARN to attach"
}

variable "tags" {
  type        = map(string)
  default     = {}
}