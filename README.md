# terraform-tfe-nocode-lz

## About
A no-code module to create landing zone resources including a management workspace spawned from a template repo, allowing
various LZ archetypes to be chosen.

<!-- BEGIN_TF_DOCS -->

### Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_team.team](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team_project_access.levels](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_workspace.lz_management](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | a set of tags to watermark the resources you deployed with Terraform. | `map(string)` | <pre>{<br>  "owner": "richard",<br>  "terraformed": "Do not edit manually."<br>}</pre> | no |
| lz\_template | Git template repository to use for the management workspace | `any` | n/a | yes |
| organization | TFC organization | `string` | n/a | yes |
| project\_name | Name of the project to create a landing zone for | `string` | n/a | yes |
| project\_prefix | Prefix of the TFE project name | `string` | `"nocode-lz"` | no |

### Outputs

No outputs.

<!-- END_TF_DOCS -->