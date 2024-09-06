variable "tfc_hcp_vault_hvn_id" {
  type = string
  description = "The ID of the HVN this HCP Vault cluster is associated to"
  default = "tfc-hcp-vault-hvn"
}

variable "tfc_hcp_vault_provider" {
  type = string
  description = "The provider where the HCP Vault cluster is located"
  default = "aws"
}

variable "tfc_hcp_vault_region" {
  type = string
  description = "The region where the HCP Vault cluster is located"
  default = "ap-southeast-1"
}

variable "tfc_hcp_vault_cidr" {
  type = string
  description = "The CIDR block of the HVN this HCP Vault cluster is associated to"
  default = "172.25.16.0/20"
}

variable "tfc_hcp_vault" {
  type = string
  description = "The ID of the HCP Vault cluster"
  default = "tfc-hcp-vault"
}

variable "tfc_hcp_vault_tier" {
  type = string
  description = "The tier of the HCP Vault cluster"
  default = "dev"
}