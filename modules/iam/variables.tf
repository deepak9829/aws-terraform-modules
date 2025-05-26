variable "iam_roles" {
  description = "List of IAM roles with optional inline and managed policies"
  type = list(object({
    name                    = string
    assume_role_policy      = string
    create_policy           = optional(bool, false)
    policy_name             = optional(string)
    policy_description      = optional(string)
    policy_document         = optional(string)
    aws_managed_policy_arns = optional(list(string), [])
    tags                    = optional(map(string), {})
  }))
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default     = {}
}
