# modules/cloud_function/outputs.tf
output "function_name" {
  description = "The name of the Cloud Function"
  value       = google_cloudfunctions_function.hello_world.name
}

output "function_url" {
  description = "The HTTPS trigger URL for the Cloud Function"
  value       = google_cloudfunctions_function.hello_world.https_trigger_url
}

output "url" {
  description = "The HTTPS trigger URL for the Cloud Function"
  value       = google_cloudfunctions_function.hello_world.https_trigger_url
}