
# modules/network_endpoint_group/outputs.tf
output "neg_id" {
  description = "The ID of the Network Endpoint Group"
  value       = google_compute_region_network_endpoint_group.neg.id
}