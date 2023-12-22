# Copyright (c) Çetin ARDAL
# SPDX-License-Identifier: MIT

terraform {
  # Terraform cli version
  required_version = ">= 1.5.0"
  # Backend on Terraform Cloud or Terraform Enterprise
  # comment the cloud{} block to work with local state.

}

locals {
  project_name = "${var.project_prefix}-${var.project_name}"
  teams        = toset(["admin", "write", "maintain", "read"])
  mgmt_ws_name = "project-${var.project_name}-lz-management"
}

resource "tfe_project" "this" {
  organization = var.organization
  name         = local.project_name
}

resource "tfe_team" "team" {
  for_each = local.teams

  organization = var.organization
  name         = "proj-${var.project_name}-${each.key}"
}

resource "tfe_team_project_access" "levels" {
  for_each = tfe_team.team

  access     = each.key
  team_id    = each.value.id
  project_id = tfe_project.this.id
}

resource "tfe_workspace" "lz_management" {
  name         = local.mgmt_ws_name
  organization = var.organization
  project_id   = tfe_project.this.id
  tag_names    = ["management", "lz", var.project_name]
}