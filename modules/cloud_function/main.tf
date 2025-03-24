resource "random_id" "bucket_suffix" {
  byte_length = 4
}
resource "google_storage_bucket" "source_bucket" {
  name     = "hello-world-source-${var.project_id}-${random_id.bucket_suffix.hex}"
  location = var.region
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "./function"
  output_path = "./hello_world.zip"
}

resource "google_storage_bucket_object" "source" {
  name   = "hello_world.zip"
  bucket = google_storage_bucket.source_bucket.name
  source = data.archive_file.source.output_path
}

resource "google_cloudfunctions_function" "hello_world" {
  name        = "hello-world-function"
  runtime     = "python39"
  entry_point = "hello_world"

  source_archive_bucket = google_storage_bucket.source_bucket.name
  source_archive_object = google_storage_bucket_object.source.name
  trigger_http          = true
  ingress_settings      = "ALLOW_INTERNAL_AND_GCLB"
  available_memory_mb   = 128
  region                = var.region
  project               = var.project_id

}

resource "google_cloudfunctions_function_iam_member" "public_invoker" {
  cloud_function = google_cloudfunctions_function.hello_world.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}

resource "random_id" "backend_suffix" {
  byte_length = 4
}

resource "google_compute_backend_service" "backend_service" {
  name = "lb-backend-service-${random_id.backend_suffix.hex}"

  backend {
    group = var.neg_id # Use variable input
  }
}





