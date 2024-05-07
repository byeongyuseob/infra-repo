locals {
  region = "ap-northeast-2"
  name   = "byeongyuseob-cluster"
  vpc_cidr = "10.123.0.0/16"
  azs      = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets  = ["10.123.1.0/24", "10.123.2.0/24"]
  private_subnets = ["10.123.3.0/24", "10.123.4.0/24"]
  intra_subnets   = ["10.123.5.0/24", "10.123.6.0/24"]
  tags = {
    Example = local.name
  }
}

provider "aws" {
  region = "ap-northeast-2"
}