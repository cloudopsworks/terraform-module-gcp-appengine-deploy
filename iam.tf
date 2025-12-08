##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "google_client_config" "current" {}
data "google_client_openid_userinfo" "current" {}

resource "google_service_account" "appengine_sa" {
  account_id   = local.release_name
  display_name = "${local.release_name} Service Account"
  description  = "Service Account for ${local.release_name} App Engine Application"
}

resource "google_project_iam_member" "gae_api" {
  project = google_service_account.appengine_sa.project
  role    = "roles/compute.networkUser"
  member  = google_service_account.appengine_sa.member
}

resource "google_project_iam_member" "log_writer" {
  project = google_service_account.appengine_sa.project
  role    = "roles/logging.logWriter"
  member  = google_service_account.appengine_sa.member
}

resource "google_project_iam_member" "registry_writer" {
  project = google_service_account.appengine_sa.project
  role    = "roles/artifactregistry.writer"
  member  = google_service_account.appengine_sa.member
}

resource "google_storage_bucket_iam_binding" "bucket_access" {
  bucket  = var.versions_bucket
  role    = "roles/storage.objectAdmin"
  members = [google_service_account.appengine_sa.member]
}

resource "google_service_account_iam_binding" "allow_impersonation" {
  service_account_id = google_service_account.appengine_sa.id
  role               = "roles/iam.serviceAccountUser"
  members            = ["serviceAccount:${data.google_client_openid_userinfo.current.email}"]
}

