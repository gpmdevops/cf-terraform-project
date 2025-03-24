resource "random_id" "ip_suffix" {
  byte_length = 4
}
resource "google_compute_global_address" "static_ip" {
  name = "lb-static-ip-${random_id.ip_suffix.hex}"
}


resource "random_id" "neg_suffix" {
  byte_length = 4
}

resource "google_compute_region_network_endpoint_group" "neg" {
  name                  = "hello-world-neg-${random_id.neg_suffix.hex}"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_function {
    function = var.function_name
  }

}

resource "random_id" "backend_suffix" {
  byte_length = 4
}

resource "google_compute_backend_service" "backend_service" {
  name = "lb-backend-service-${random_id.backend_suffix.hex}"
  #
  protocol  = "HTTP"
  port_name = "http"

  backend {
    group = google_compute_region_network_endpoint_group.neg.id
  }

  #
}

resource "random_id" "url_map_suffix" {
  byte_length = 4
}

resource "google_compute_url_map" "url_map" {
  name            = "lb-url-map-${random_id.url_map_suffix.hex}"
  default_service = google_compute_backend_service.backend_service.self_link
}
resource "google_compute_ssl_certificate" "ssl_cert" {
  name        = "lb-ssl-cert"
  private_key = file("${path.module}/self-signed.key")
  certificate = file("${path.module}/self-signed.crt")
}

resource "random_id" "https_proxy_suffix" {
  byte_length = 4
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "lb-https-proxy-${random_id.https_proxy_suffix.hex}"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [google_compute_ssl_certificate.ssl_cert.id]
}


resource "random_id" "forwarding_rule_suffix" {
  byte_length = 4
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "lb-forwarding-rule-${random_id.forwarding_rule_suffix.hex}"
  target     = google_compute_target_https_proxy.https_proxy.id
  port_range = "443"
}


output "lb_static_ip" {
  value = google_compute_global_address.static_ip.address
}
