output "cloud_function_url" {
  description = "Cloud Function URL"
  value       = module.cloud_function.url
}

output "load_balancer_ip" {
  description = "Global static IP of Load Balancer"
  value       = module.load_balancer.lb_ip
}


# outputs.tf
output "neg_id" {
  description = "The ID of the Network Endpoint Group (NEG)"
  value       = module.network_endpoint_group.neg_id
}