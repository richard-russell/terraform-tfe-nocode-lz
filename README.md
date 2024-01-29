# terraform-tfe-nocode-lz-flexible-aws

## About
A no-code module to create landing zone resources including a management workspace chosen from a list of template repos, allowing various LZ archetypes to be chosen.

This module should contain centrally-managed resources under the control of the platfom team, e.g:
TFC/E resources
- LZ Project
- Project teams (read, write, maintain)
- Project team access
- LZ management workspace
- Variable sets, variables
- Sentinel policy-sets
Git VCS resources
- Management LZ repository - select from templates
- Teams
CSP resources
- Dynamic creds (OIDC, roles, policies)

The management workspace is spawned from a choice of templates, allowing the platform team to define a number of different archetypes as starting points for the LZ structure. The management workspace / repo are then under the control of the app team, who are free to adapt and evolve the workspace structure to meet the changing needs of the project.

No-code workspace to be placed in a project with varset including:
- TFE_TOKEN - env variable - capable of creating projects and teams
- GITHUB_TOKEN - env variable - capable of creating repos and webhooks
- github_owner - terraform variable - github individual or organization
- tfc_organization - terraform variable - TFC/TFE organization
- oauth_token_id - terraform variable - oauth token ID of existing VCS connection, used to create the VCS-backed workspaces

<!-- BEGIN_TF_DOCS -->

### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.0 |
| github | 5.42.0 |
| tfe | 0.51.1 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [github_repository.mgmt_ws_repo](https://registry.terraform.io/providers/integrations/github/5.42.0/docs/resources/repository) | resource |
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/project) | resource |
| [tfe_project_variable_set.project](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/project_variable_set) | resource |
| [tfe_team.team](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/team) | resource |
| [tfe_team_project_access.levels](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/team_project_access) | resource |
| [tfe_variable.iac_repo_template](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/variable) | resource |
| [tfe_variable.project_name](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/variable) | resource |
| [tfe_variable.tfc_project](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/variable) | resource |
| [tfe_variable_set.project](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/variable_set) | resource |
| [tfe_workspace.lz_management](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/workspace) | resource |
| [tfe_workspace_variable_set.nclz_core](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/resources/workspace_variable_set) | resource |
| [tfe_variable_set.nclz_core](https://registry.terraform.io/providers/hashicorp/tfe/0.51.1/docs/data-sources/variable_set) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | a set of tags to watermark the resources you deployed with Terraform. | `map(string)` | <pre>{<br>  "owner": "richard",<br>  "terraformed": "Do not edit manually."<br>}</pre> | no |
| github\_owner | Owner of the Github org | `string` | `""` | no |
| iac\_repo\_template | Template to use for IAC repo creation | `string` | `"terraform-generic-template"` | no |
| lz\_archetype | Github template repo to use for the LZ mgmt workspace repo | `string` | n/a | yes |
| mgmt\_ws\_prefix | String to prefix the archetype name to give mgmt workspace and repo names | `string` | `"nclz-mgmt"` | no |
| mgmt\_ws\_template\_prefix | String to prefix the archetype name to give mgmt template repo name | `string` | `"nocode-lz-mgmt-template"` | no |
| oauth\_token\_id | Oauth token ID used for associating workspace to VCS | `string` | `""` | no |
| project\_name | Name of the project to create a landing zone for | `string` | n/a | yes |
| project\_prefix | Prefix for the TFE project name within the nocode module | `string` | `"nclz-project"` | no |
| tfc\_organization | TFC organization | `string` | `""` | no |

### Outputs

No outputs.

<!-- END_TF_DOCS -->