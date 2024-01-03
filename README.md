# terraform-tfe-nocode-lz

## About
A no-code module to create landing zone resources including a management workspace spawned from a template repo, allowing
various LZ archetypes to be chosen.

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
| iac\_repo\_template | Template to use for OAC repo creation | `string` | `"terraform-generic-template"` | no |
| lz\_archetype | Github template repo to use for the LZ mgmt workspace repo | `string` | n/a | yes |
| mgmt\_ws\_prefix | String to prefix the archetype name to give mgmt workspace and repo names | `string` | `"nocode-lz-mgmt"` | no |
| mgmt\_ws\_template\_prefix | String to prefix the archetype name to give mgmt template repo name | `string` | `"nocode-lz-mgmt-template"` | no |
| oauth\_token\_id | Oauth token ID used for associating workspace to VCS | `string` | `""` | no |
| project\_name | Name of the project to create a landing zone for | `string` | n/a | yes |
| project\_prefix | Prefix for the TFE project name within the nocode module | `string` | `"nocode-lz"` | no |
| tfc\_organization | TFC organization | `string` | `""` | no |

### Outputs

No outputs.

<!-- END_TF_DOCS -->