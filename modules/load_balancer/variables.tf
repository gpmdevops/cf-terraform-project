variable "neg_id" {
  description = "Serverless NEG ID"
  type        = string
}
# modules/load_balancer/variables.tf
variable "region" {
  description = "The GCP region where the NEG will be created"
  type        = string
}

variable "function_name" {
  description = "The name of the Cloud Function"
  type        = string
}