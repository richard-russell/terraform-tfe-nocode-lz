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

# pass the nclz var set onto the mgmt workspace
data "tfe_variable_set" "nclz_core" {
  organization = var.tfc_organization
  name         = "nclz_core"
}

resource "tfe_workspace_variable_set" "nclz_core" {
  variable_set_id = data.tfe_variable_set.nclz_core.id
  workspace_id    = tfe_workspace.lz_management.id
}

resource "tfe_variable" "iac_repo_template" {
  key          = "iac_repo_template"
  value        = var.iac_repo_template
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = false
  description  = "Template to use for OAC repo creation"
}

resource "tfe_variable" "tfc_project" {
  key          = "tfc_project"
  value        = tfe_project.this.name
  category     = "terraform"
  workspace_id = tfe_workspace.lz_management.id
  sensitive    = false
  description  = "TFC project ID"
}
