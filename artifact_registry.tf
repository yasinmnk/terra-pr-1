resource "google_artifact_registry_repository" "api_artifactory" {
  location      = var.location
  repository_id = var.artifactory_repo_id
  description   = "repository for restapi docker images"
  format        = var.artifactory_format
}