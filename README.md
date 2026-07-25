# Local CI/CD Pipeline

## Overview

This project demonstrates a local CI/CD pipeline using GitHub, Jenkins, Docker, and Terraform. Jenkins automatically detects changes in the GitHub repository, builds a Docker image for the Flask application, and uses Terraform to deploy the application as a Docker container.
## Running the Application

### Build the Docker image
* This image name is the one I used and it may be different for you.

```bash
docker build -t class-proj-app:latest .
```

### Deploy with Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Access the application

Open your web browser and go to:

```text
http://localhost:5000
```

## Jenkins

Jenkins runs in a Docker container and is available at:

```text
http://localhost:8080
```

The Jenkins pipeline performs the following steps:

1. Checks out the GitHub repository
2. Builds the Docker image
3. Initializes Terraform
4. Validates the Terraform configuration
5. Runs `terraform apply`
6. Verifies the application is running
