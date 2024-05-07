module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                   = local.name
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.small"]

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    development = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "dev-eks-cluster"
      }
    },
    production = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "prod-eks-cluster"
      }
    }
  }

  tags = local.tags
}