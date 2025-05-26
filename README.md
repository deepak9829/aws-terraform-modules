# AWS Terraform Modules

This repository contains reusable Terraform modules for provisioning key AWS infrastructure components, including:

- Amazon EKS (Elastic Kubernetes Service)
- Amazon VPC (Virtual Private Cloud)
- IAM (Identity and Access Management)

These modules are designed for consistency, reusability, and best practices across environments like dev, staging, and production.

## 📁 Directory Structure

aws-terraform-modules/
└── modules/
├── eks/ # EKS cluster and managed node groups
├── vpc/ # VPC, public subnets
└── iam/ # IAM roles and policies for EKS



---

## 🧱 Modules

### 1. `vpc/`

Creates a VPC with public subnets.

**Inputs:**

- `vpc_cidr` (string): CIDR block for the VPC.
- `public_subnet_cidrs` (list): CIDR blocks for public subnets.
- `azs` (list): Availability zones.
- `tags` (map): Tags to apply.

**Outputs:**

- `vpc_id`: The VPC ID.
- `public_subnet_ids`: List of public subnet IDs.

---

### 2. `iam/`

Creates an IAM role and attaches a policy (used by EKS).

**Inputs:**

- `role_name` (string): IAM role name.
- `assume_role_policy` (string): JSON policy document for assume role.
- `policy_arn` (string): ARN of the policy to attach.
- `tags` (map): Tags to apply.

**Outputs:**

- `role_arn`: The ARN of the created IAM role.

---

### 3. `eks/`

Provisions an EKS cluster using [terraform-aws-modules/eks](https://github.com/terraform-aws-modules/terraform-aws-eks).

**Inputs:**

- `cluster_name` (string): EKS cluster name.
- `k8s_version` (string): Kubernetes version.
- `vpc_id` (string): VPC ID to deploy the cluster.
- `subnet_ids` (list): Subnet IDs for worker nodes.
- `eks_node_groups` (map): Node group configurations.
- `tags` (map): Tags to apply.

**Outputs:**

- `cluster_id`: ID of the EKS cluster.
- `cluster_endpoint`: Endpoint of the EKS cluster.
- `node_group_role_arn`: IAM role ARN for the node group.

---

## 🚀 Example Usage

```hcl
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs                 = ["ap-southeast-1a", "ap-southeast-1b"]
  tags                = { Environment = "dev" }
}

module "iam" {
  source              = "./modules/iam"
  role_name           = "eks-cluster-role"
  assume_role_policy  = data.aws_iam_policy_document.eks_assume_role_policy.json
  policy_arn          = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  tags                = { Environment = "dev" }
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = "demo-cluster"
  k8s_version     = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  eks_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
  tags = { Environment = "dev" }
}
