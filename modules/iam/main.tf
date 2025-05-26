resource "aws_iam_role" "this" {
  for_each = { for role in var.iam_roles : role.name => role }

  name               = each.value.name
  assume_role_policy = each.value.assume_role_policy
  tags               = merge(var.tags, lookup(each.value, "tags", {}))
}

resource "aws_iam_policy" "this" {
  for_each = {
    for role in var.iam_roles :
    role.name => role
    if lookup(role, "create_policy", false)
  }

  name        = each.value.policy_name
  path        = "/"
  description = each.value.policy_description
  policy      = each.value.policy_document
  tags        = merge(var.tags, lookup(each.value, "tags", {}))
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = {
    for role in var.iam_roles :
    role.name => role
    if lookup(role, "create_policy", false)
  }

  role       = aws_iam_role.this[each.key].name
  policy_arn = aws_iam_policy.this[each.key].arn
}

resource "aws_iam_role_policy_attachment" "aws_managed" {
  for_each = {
    for role in var.iam_roles :
    role.name => role
    if length(lookup(role, "aws_managed_policy_arns", [])) > 0
  }

  count      = length(each.value.aws_managed_policy_arns)
  role       = aws_iam_role.this[each.key].name
  policy_arn = each.value.aws_managed_policy_arns[count.index]
}
