# Create a Vault cluster at HCP
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

#######################################################################

# Create an IAM user with related policy to connect Vault with AWS
resource "aws_iam_user" "vault_admin" {
  name = var.vault_admin_name
  path = "/"
  tags = {
    tag-key = var.vault_admin_name
  }
}

resource "aws_iam_access_key" "vault_admin_access_key" {
  user = aws_iam_user.vault_admin.name
  lifecycle {
    ignore_changes = [
    user
    ]
  }
}

resource "aws_iam_user_policy" "vault_admin_policy_attach" {
  name   = var.vault_admin_policy
  user   = aws_iam_user.vault_admin.name
  policy = data.aws_iam_policy_document.vault_admin_policy.json
}