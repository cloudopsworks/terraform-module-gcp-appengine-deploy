##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "google_app_engine_application" "app" {
  project     = try(var.appengine.project_id, null)
  location_id = try(var.appengine.region, null)

}
