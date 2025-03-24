package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCloudFunction(t *testing.T) {
	// Define the Terraform options
	terraformOptions := &terraform.Options{
		TerraformDir: "../", // Path to the root Terraform directory
	}

	// Defer the destruction of resources
	defer terraform.Destroy(t, terraformOptions)

	// Apply the Terraform configuration
	terraform.InitAndApply(t, terraformOptions)

	// Get the Cloud Function URL output
	cloudFunctionURL := terraform.Output(t, terraformOptions, "cloud_function_url")

	// Test that the Cloud Function URL is not empty
	assert.NotEmpty(t, cloudFunctionURL, "Cloud Function URL should not be empty")
}
