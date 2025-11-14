##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
locals {
  tags = merge(var.extra_tags, {
    Environment = format("%s-%s", var.release.name, var.namespace)
    Namespace   = var.namespace
    Release     = var.release.name
  })
  qualifier       = try(var.release.qualifier, "")
  release_name    = length(local.qualifier) > 0 ? format("%s-%s-%s", var.release.name, var.namespace, local.qualifier) : format("%s-%s", var.release.name, var.namespace)
  engine_standard = try(var.appengine.type, "standard") == "standard" ? true : false
}

resource "google_app_engine_standard_app_version" "app_version" {
  count      = local.engine_standard ? 1 : 0
  version_id = lower(replace(var.version_label, "/[_.]/", "-"))
  service    = local.release_name
  runtime    = var.appengine.runtime
  entrypoint {
    shell = var.appengine.entrypoint_shell
  }
  env_variables = var.appengine.env_variables
  dynamic "automatic_scaling" {
    for_each = length(try(var.appengine.instance.auto_scaling, [])) > 0 ? [1] : []
    content {
      max_concurrent_requests = try(var.appengine.instance.auto_scaling.max_concurrent_requests, null)
      min_idle_instances      = try(var.appengine.instance.auto_scaling.min_idle, null)
      max_idle_instances      = try(var.appengine.instance.auto_scaling.max_idle, null)
      min_pending_latency     = try(var.appengine.instance.auto_scaling.min_pending_latency, null)
      max_pending_latency     = try(var.appengine.instance.auto_scaling.max_pending_latency, null)
      standard_scheduler_settings {
        target_cpu_utilization        = try(var.appengine.instance.auto_scalint.target_cpu, null)
        target_throughput_utilization = try(var.appengine.instance.auto_scaling.target_throughput, null)
        max_instances                 = try(var.appengine.instance.auto_scaling.max, null)
        min_instances                 = try(var.appengine.instance.auto_scaling.min, null)
      }
    }
  }
  dynamic "basic_scaling" {
    for_each = length(try(var.appengine.instance.basic_scaling, [])) > 0 ? [1] : []
    content {
      max_instances = var.appengine.instance.basic_scaling.max
      idle_timeout  = var.appengine.instance.basic_scaling.idle_timeout
    }
  }
  dynamic "manual_scaling" {
    for_each = length(try(var.appengine.instance.manual_scaling, [])) > 0 ? [1] : []
    content {
      instances = var.appengine.instance.manual_scaling.count
    }
  }
  delete_service_on_destroy = true
  service_account           = google_service_account.appengine_sa.email
  instance_class            = var.appengine.instance.class
  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${var.versions_bucket}/${var.bucket_path}"
    }
  }

}

# resource "google_app_engine_flexible_app_version" "app_version" {
#   version_id = var.version_label
#   service    = local.release_name
#   runtime    = var.appengine.runtime
#   entrypoint {
#     shell = var.appengine.entrypoint_shell
#   }
# }