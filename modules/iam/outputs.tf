output "iam_roles" {
  value = {
    for name, role in aws_iam_role.this :
    name => {
      name = role.name
      arn  = role.arn
    }
  }
}
