# Copyright (c) Çetin ARDAL
# SPDX-License-Identifier: MIT

terraform {
  # Terraform cli version
  required_version = ">= 1.6.0"
  # Backend on Terraform Cloud or Terraform Enterprise
  # comment the cloud{} block to work with local state.
}

provider "github" {}
provider "tfe" {}

locals {
  project_name          = "${var.project_prefix}-${var.project_name}"
  teams                 = toset(["admin", "write", "maintain", "read"])
  mgmt_ws_name          = "project-${var.project_name}-lz-management"
  mgmt_ws_template_name = "${var.mgmt_ws_template_prefix}-${var.lz_archetype}"
}

resource "tfe_project" "this" {
  organization = var.tfc_organization
  name         = local.project_name
}

resource "tfe_team" "team" {
  for_each = local.teams

  organization = var.tfc_organization
  name         = "proj-${var.project_name}-${each.key}"
}

resource "tfe_team_project_access" "levels" {
  for_each = tfe_team.team

  access     = each.key
  team_id    = each.value.id
  project_id = tfe_project.this.id
}

resource "github_repository" "mgmt_ws_repo" {
  name        = local.mgmt_ws_name
  description = "Landing Zone management repo for project ${var.project_name}"

  visibility = "private"

  template {
    owner                = var.github_owner
    repository           = local.mgmt_ws_template_name
    include_all_branches = false
  }
}

resource "tfe_workspace" "lz_management" {
  name         = local.mgmt_ws_name
  organization = var.tfc_organization
  project_id   = tfe_project.this.id
  tag_names    = ["management", "lz", var.project_name, var.lz_archetype]
  vcs_repo {
    branch         = "main"
    identifier     = github_repository.mgmt_ws_repo.full_name
    oauth_token_id = var.oauth_token_id
  }

}

# Common variables for project
resource "tfe_variable_set" "project" {
  name         = local.project_name
  organization = var.tfc_organization
}

resource "tfe_variable" "project_name" {
  key             = "project_name"
  value           = var.project_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.project.id
  sensitive       = false
}

resource "tfe_project_variable_set" "project" {
  variable_set_id = tfe_variable_set.project.id
  project_id      = tfe_project.this.id
}

resource "tfe_variable" "github_owner" {
  key          = "github_owner"
  value        = var.github_owner
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = false
  description  = "Owner of the Github org"
}

resource "tfe_variable" "iac_repo_template" {
  key          = "iac_repo_template"
  value        = var.iac_repo_template
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = false
  description  = "Template to use for OAC repo creation"
}

resource "tfe_variable" "oauth_token_id" {
  key          = "oauth_token_id"
  value        = var.oauth_token_id
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = true
  description  = "Oauth token ID used for associating workspace to VCS"
}

resource "tfe_variable" "tfc_organization" {
  key          = "tfc_organization"
  value        = var.tfc_organization
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = false
  description  = "TFC organization"
}

resource "tfe_variable" "tfc_project" {
  key          = "tfc_project"
  value        = tfe_project.this.name
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = false
  description  = "TFC project ID"
}

resource "tfe_variable" "TFE_TOKEN" {
  key          = "TFE_TOKEN"
  value        = var.tfe_token
  category     = "env"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = true
  description  = "TFC token - to pass through to mgmt ws as env variable"
}

resource "tfe_variable" "GITHUB_TOKEN" {
  key          = "GITHUB_TOKEN"
  value        = var.github_token
  category     = "env"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = true
  description  = "Github token - to pass through to mgmt ws as env variable"
}
