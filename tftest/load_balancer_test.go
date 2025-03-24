package test

import (
	"testing"
	"net/http"
	"time"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestLoadBalancer(t *testing.T) {
	// Define the Terraform options
	terraformOptions := &terraform.Options{
		TerraformDir: "../", // Path to the root Terraform directory
	}

	// Defer the destruction of resources
	defer terraform.Destroy(t, terraformOptions)

	// Apply the Terraform configuration
	terraform.InitAndApply(t, terraformOptions)

	// Get the Load Balancer IP output
	loadBalancerIP := terraform.Output(t, terraformOptions, "load_balancer_ip")

	// Test that the Load Balancer IP is not empty
	assert.NotEmpty(t, loadBalancerIP, "Load Balancer IP should not be empty")

	// Test that the Load Balancer is accessible
	url := "http://" + loadBalancerIP
	client := http.Client{Timeout: 10 * time.Second}
	resp, err := client.Get(url)
	assert.NoError(t, err, "Load Balancer should be accessible")
	assert.Equal(t, http.StatusOK, resp.StatusCode, "Load Balancer should return HTTP 200")
}
