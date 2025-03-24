# modules/load_balancer/outputs.tf
output "lb_ip" {
  description = "The IP address of the Load Balancer"
  value       = google_compute_global_forwarding_rule.forwarding_rule.ip_address
}

