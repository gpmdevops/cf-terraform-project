
# modules/network_endpoint_group/main.tf
resource "google_compute_region_network_endpoint_group" "neg" {
  name                  = "hello-world-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_function {
    function = var.function_name
  }
}

