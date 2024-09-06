resource "hcp_hvn" "tfc_hcp_vault_hvn" {
  hvn_id         = var.tfc_hcp_vault_hvn_id
  cloud_provider = var.tfc_hcp_vault_provider
  region         = var.tfc_hcp_vault_region
  cidr_block     = var.tfc_hcp_vault_cidr
}

resource "hcp_vault_cluster" "tfc_hcp_vault" {
  cluster_id = var.tfc_hcp_vault
  hvn_id     = hcp_hvn.tfc_hcp_vault_hvn.hvn_id
  tier       = var.tfc_hcp_vault_tier
  public_endpoint = true
}