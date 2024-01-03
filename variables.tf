# Copyright (c) Çetin ARDAL
# SPDX-License-Identifier: MIT

locals {
  formatted_timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
}

variable "default_tags" {
  type        = map(string)
  description = "a set of tags to watermark the resources you deployed with Terraform."
  default = {
    owner       = "richard" // update me
    terraformed = "Do not edit manually."
  }
}

variable "github_owner" {
  type        = string
  description = "Owner of the Github org"
}

variable "github_token" {
  type        = string
  description = "Github token to pass through to mgmt ws"
}

variable "tfe_token" {
  type        = string
  description = "TFE token to pass through to mgmt ws"
}

variable "iac_repo_template" {
  type        = string
  description = "Template to use for OAC repo creation"
}

variable "lz_archetype" {
  type        = string
  description = "Github template repo to use for the LZ mgmt workspace repo"
}

variable "mgmt_ws_prefix" {
  type        = string
  description = "String to prefix the archetype name to give mgmt workspace and repo names"
  default     = "nocode-lz-mgmt"
}

variable "mgmt_ws_template_prefix" {
  type        = string
  description = "String to prefix the archetype name to give mgmt template repo name"
  default     = "nocode-lz-mgmt-template"
}

variable "oauth_token_id" {
  type        = string
  description = "Oauth token ID used for associating workspace to VCS"
}

variable "tfc_organization" {
  type        = string
  description = "TFC organization"
}

variable "project_name" {
  type        = string
  description = "Name of the project to create a landing zone for"
}

variable "project_prefix" {
  type        = string
  description = "Prefix for the TFE project name within the nocode module"
  default     = "nocode-lz"
}
