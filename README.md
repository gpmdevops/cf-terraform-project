# Terraform Project: Hello World with GCP Cloud Function and Load Balancer
- This project demonstrates how to deploy a simple "Hello World" application using Google Cloud Platform (GCP). 
- The application is built using a Cloud Function, exposed through a Load Balancer, and secured with appropriate configurations. 
- The entire infrastructure is defined using Terraform, an infrastructure-as-code tool.

# More about This Project-
- Cloud Function: A serverless function that returns "Hello World!" when accessed.

- Load Balancer: Distributes incoming traffic to the Cloud Function.

- Security: Implements secure configurations for the Cloud Function and Load Balancer.

- Automated Testing: Uses Terratest to validate the infrastructure.
![graph](https://github.com/user-attachments/assets/6f99c9cd-596f-4f75-a1ec-c7078e94c179)


# Prerequisites
This projec requires following prerquisites:-

. Google Cloud Account: A GCP account with a project created.

. Terraform Installed: Install Terraform from here.

. Google Cloud SDK: Install the Google Cloud SDK from here.

. Go Installed: Install Go from here (required for Terratest).

# How to Use This Project
1. Clone the Repository
Clone this repository to your local machine:
```
git clone https://github.com/your-repo/terraform-gcf.git
cd terraform-gcf
```
2. Set Up Google Cloud
- Authenticate with GCP:
```
gcloud auth application-default login
```

- Set Your GCP Project:
```
gcloud config set project YOUR_PROJECT_ID
```

3. Initialize Terraform
```
terraform init
```
4. Deploy the Infrastructure
```
terraform apply
```
Terraform will show you a plan of the resources it will create. Type yes to confirm and proceed.

5. Test the Deployment:
Once the deployment is complete, Terraform will output the following:

Cloud Function URL: The URL to access the Cloud Function directly.

Load Balancer IP: The public IP address of the Load Balancer.

Access the Cloud Function

Open the Cloud Function console and test the connection:
```
curl -m 70 -X POST https://us-central1-hello-world-454204.cloudfunctions.net/hello-world-function \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{
    "message": "Hello World"
}'
 response: " Hi There, Its a deployment on Cloudfunction_1stgen "

#Access the Load Balancer
#the same test goes for the loadbalancer also.
#if we need the function to hit only by lb ip then we need to change the permission to lb only.

```
![Screensh0t1](https://github.com/user-attachments/assets/e90aa82b-50e2-4404-b38e-d642f6f185cb)

![Screenshot2](https://github.com/user-attachments/assets/4fb7f8f9-6068-4ca8-9dc3-02b4462cf77a)

6. Run Automated Tests:
This project includes automated tests using Terratest. To run the tests:

Navigate to the tests directory:

```
cd tests
go test -v
```
The tests will:

- Deploy the infrastructure.
- Validate the Cloud Function and Load Balancer.
- Destroy the infrastructure after the test.

7. Clean Up:-
Destroy the infrastructure to avoid unnecessary charges, after completing the project:
```
terraform destroy
#Type yes to confirm and proceed.
```

Project Structure:-
Here’s an overview of the files and directories in this project:


![Screenshot3](https://github.com/user-attachments/assets/b9da7b2a-3322-487d-8984-061cf92925cd)

What’s Inside the Terraform Code?
1. Cloud Function-
   . A simple Python function that returns "Hello World!".
   . Deployed using a serverless Cloud Function.
   . Configured to allow traffic from the Load Balancer.


2. Load Balancer-
   . A global HTTP(S) Load Balancer that distributes traffic to the Cloud Function.
   . Uses a Serverless Network Endpoint Group (NEG) to connect to the Cloud Function.
   . Secured with an SSL certificate

3. Security
   . Restricts access to the Cloud Function using IAM roles.
   . Ensures only the Load Balancer can invoke the Cloud Function.

# Why?
1. Why is the Cloud Function URL not public?
   
- By default, Cloud Functions are configured to allow only internal traffic or traffic from the Load Balancer.
  To make the URL public, set the ingress_settings to ALLOW_ALL in the Cloud Function configuration.




