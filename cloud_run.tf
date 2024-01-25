
locals {
  tag                = "v1"
  img_name           = "instances_api"
  artifactory_format = "docker"
}

resource "google_cloud_run_v2_service" "controll_instance_api" {
  name     = var.cr_app_name
  location = var.location
  project  = var.project_id

  template {

    containers {

      image =  var.runimage  #"${var.location}-${local.artifactory_format}.pkg.dev/${var.project_id}/${var.artifactory_repo_id}/${local.img_name}:${local.tag}"
      ports {

        container_port = var.container_port
      }
    }

    service_account = google_service_account.fastapi_service_account.email
  }
}


#Allow unauthenticated invocations
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# resource "google_cloud_run_service_iam_policy" "noauth" {
#   location    = google_cloud_run_v2_service.cr_nginx_app.location
#   service     = google_cloud_run_v2_service.cr_nginx_app.name
#   policy_data = data.google_iam_policy.noauth.policy_data
#   project     = var.project_id
# }