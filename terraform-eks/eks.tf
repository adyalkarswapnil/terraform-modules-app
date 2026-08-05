module "eks" {
  #import the module template
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  #cluster info(control plane)
  cluster_name = local.name
  cluster_endpoint_public_access  = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_addons = {
    vpc_cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    core-dns = {
      most_recent = true
    }
  }

  #control plane network
  control_plane_subnet_ids = module.vpc.intra_subnets


  #managing nodes in the cluster
  eks_managed_node_groups_defaults = {

    instance_types = ["c7i-flex.large"]
    attach_cluster_primary_security_group = true
  }

 eks_managed_node_groups {
 tws-cluster-ng = {
 instance_types = ["c7i-flex.large"]
 min_size = 2
 max_size = 3
 desired_size = 2
 capacity_type = "SPOT"
}
}

    tags = {
    Environment = "local.evn"
    Terraform   = "true"
  }
}
