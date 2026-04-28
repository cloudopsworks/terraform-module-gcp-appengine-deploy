## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [google_app_engine_standard_app_version.app_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/app_engine_standard_app_version) | resource |
| [google_project_iam_member.gae_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.log_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.registry_writer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.appengine_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.allow_impersonation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_storage_bucket_iam_binding.bucket_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_client_config.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_client_openid_userinfo.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_openid_userinfo) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_absolute_path"></a> [absolute\_path](#input\_absolute\_path) | Absolute path to the application source code. | `string` | n/a | yes |
| <a name="input_appengine"></a> [appengine](#input\_appengine) | App Engine application configuration. | `any` | `{}` | no |
| <a name="input_bucket_path"></a> [bucket\_path](#input\_bucket\_path) | Path to the Google Storage Bucket | `string` | `""` | no |
| <a name="input_dns"></a> [dns](#input\_dns) | DNS configuration for custom domains. | `any` | `{}` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the App Engine application. | `string` | `"default"` | no |
| <a name="input_observability"></a> [observability](#input\_observability) | Observability configuration for monitoring and logging. | `any` | `{}` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP Region where App Engine will be created. | `string` | `"us-central1"` | no |
| <a name="input_release"></a> [release](#input\_release) | Release information for tagging and versioning. | `any` | `{}` | no |
| <a name="input_repository_owner"></a> [repository\_owner](#input\_repository\_owner) | Owner of the source code repository. | `string` | n/a | yes |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_version_label"></a> [version\_label](#input\_version\_label) | Label for the App Engine version. | `string` | n/a | yes |
| <a name="input_versions_bucket"></a> [versions\_bucket](#input\_versions\_bucket) | GCS Bucket for storing App Engine versions. | `string` | n/a | yes |

## Outputs

No outputs.
