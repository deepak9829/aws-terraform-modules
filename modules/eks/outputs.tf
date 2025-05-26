output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_role_arn" {
  value = module.eks.node_group_iam_role_arn
}
