resource "google_service_account" "fastapi_service_account" {
  account_id   = var.srv_account_id
  display_name = "cloud run service account for python REST API"
  project      = var.project_id
}

resource "google_cloud_run_v2_service_iam_member" "srv_account_role" {
  name     = "service-account-role"
  member   = "serviceAccount:${google_service_account.fastapi_service_account.email}"
  role     = "roles/run.invoker"
  project  = var.project_id
  location = var.location

}