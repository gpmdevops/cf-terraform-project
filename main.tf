module "network_endpoint_group" {
  source        = "./modules/network_endpoint_group"
  region        = var.region
  function_name = module.cloud_function.function_name
}

module "cloud_function" {
  source     = "./modules/cloud_function"
  project_id = var.project_id
  region     = var.region
  neg_id     = module.network_endpoint_group.neg_id # Pass the NEG ID
}
# main.tf (Root Module)
module "load_balancer" {
  source        = "./modules/load_balancer"
  region        = var.region
  function_name = module.cloud_function.function_name
  neg_id        = module.network_endpoint_group.neg_id # Pass the NEG ID
}