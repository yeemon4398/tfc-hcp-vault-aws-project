variable "hvn_id" {
  description = "The ID of the HashiCorp Virtual Network (HVN)."
  type = string
  default = "tfc-hcp-vault-hvn"
}

variable "hvn_to_vpc" {
  description = "The ID of the network peering."
  type = string
  default = "hvn-to-vpc-peering"
}

variable "vpc_id" {
  description = "The ID of the peer VPC in AWS."
  type = string
  default = "vpc-0cc569beb00004abc"
}

variable "vpc_owner_id" {
  description = "The account ID of the peer VPC in AWS."
  type = string
  default = "905418458609"
}

variable "vpc_region" {
  description = "The region of the peer VPC in AWS."
  type = string
  default = "ap-southeast-1"
}

variable "private_routetable_id" {
  description = "private routetable id"
  type = string
  default = "rtb-08369292b4704a8c6"
}

variable "db_routetable_id" {
  description = "db routetable id"
  type = string
  default = "rtb-09b8c69344d4259ab"
}

# Vault Read Secret
variable "backend_path" {
    description = "Vault AWS Secret Path"
    type = string
    default = "aws-master-account"
}

variable "backend_role" {
    description = "Vault AWS Secret Role"
    type = string
    default = "master-iamadmin-role"
}

variable "aws_region" {
    description = "AWS Region for Vault AWS Secret Role"
    default = "ap-southeast-1"
}