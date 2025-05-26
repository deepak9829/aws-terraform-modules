variable "cluster_name" {
  type = string
}

variable "k8s_version" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "depends_on" {
  type    = list(any)
  default = []
}

variable "role_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
