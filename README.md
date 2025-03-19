
This repository contains the CI/CD pipeline for deploying a Dockerized Nginx application to AWS using GitHub Actions, Terraform, and Ansible. The pipeline automatically builds, tests, and deploys the app to AWS upon pushing changes to the main branch. Ansible playbook for setting up a containerised environment with Nginx, Prometheus, ELK.

The CI/CD pipeline consists of two main jobs:

1. Build Job
This job is triggered by a push to the main branch and performs the following tasks:
Checkout code: Retrieves the latest code from the repository.
Install HTML Linter: Installs the tidy HTML linter.
Lint HTML: Runs tidy to lint the index.html file for any issues.
Build Docker Image: Builds a Docker image for the Nginx app with the index.html content.
Log in to DockerHub: Authenticates with DockerHub using stored secrets (DOCKERHUB_USERNAME and DOCKERHUB_TOKEN).
Push Docker Image to DockerHub: Pushes the newly built Docker image to DockerHub.

2. Deploy Job
This job is dependent on the successful completion of the build job and performs the following tasks to deploy to AWS:
Checkout code: Retrieves the latest code from the repository.
Setup Terraform: Sets up Terraform on the runner.
Configure AWS credentials: Configures AWS credentials from stored secrets to interact with AWS services.
Terraform Init: Initializes Terraform in the terraform/ directory.
Terraform Plan: Runs terraform plan to preview the changes Terraform will make to your infrastructure.
Terraform Apply: Applies the Terraform configuration to provision resources on AWS
Waiting for Deployment to Finish: Waits for the infrastructure to be fully deployed ( 30 minutes).
Grab Terraform Outputs: Fetches the public IP address of the EC2 instance and the private key path from Terraform outputs.
Setup SSH Key: Prepares the SSH private key for connecting to the EC2 instance.
Create Ansible Inventory: Creates an Ansible inventory file with the EC2 instance's public IP.
Run Ansible Playbook on EC2: Runs an Ansible playbook (playbook.yml) on the deployed EC2 instance to install Docker and deploy the application.
Cleanup SSH Key: Removes the SSH key and inventory file after the playbook is executed.


Prerequisites
Docker: Make sure Docker is installed and DockerHub credentials are available as secrets.
Terraform: AWS credentials should be stored in GitHub Secrets.
Ansible: Ensure the playbook.yml file exists in your repository and is properly configured for deploying the Dockerised Nginx app.
AWS Setup: Terraform should be properly configured to create the necessary AWS infrastructure and Secrets ir required in GitHub Actions.
To ensure the pipeline runs successfully, you need to add the following secrets to your GitHub repository:
Go to your repo -> Settings -> Secrets and variables -> Actions -> New repository secret.
DOCKERHUB_USERNAME: DockerHub username.
DOCKERHUB_TOKEN: DockerHub access token.
AWS_ACCESS_KEY_ID: AWS access key ID.
AWS_SECRET_ACCESS_KEY: AWS secret access key.
AWS_REGION: AWS region where the resources will be deployed (e.g., eu-west-2).
EC2_USER: The SSH user for your EC2 instance.

Push changes to the main branch: Any changes pushed to the main branch will automatically trigger the CI/CD pipeline. You can test it by updating the index.html or modifying the Docker or Terraform configurations.
Monitor pipeline: You can monitor the progress of the pipeline from the Actions tab in your GitHub repository.
This pipeline includes a sleep step to ensure that AWS EC2 is fully provisioned before proceeding to the Ansible step.

The following tasks are performed by the Ansible playbook:

Install and start Docker service
Pull Docker Images: (my-nginx-app) from Docker Hub.
Prometheus, Logstash, Elasticsearch, and Kibana from Elastic's Docker registry.
Run Docker Containers:
Nginx is exposed on port 80.
Prometheus is exposed on port 9090 with its configuration file mounted.
Logstash is exposed on port 5044 for log collection.
Elasticsearch is exposed on port 9200 for storing logs.
Kibana is exposed on port 5601 for visualizing logs.

How to Use

Clone the repository:
git clone https://github.com/imobassey000/nginx-app.git
cd nginx-app
Run the yaml file .github/workflows/ci-cd.yml in your github actions
Run the Ansible playbook: Ensure Ansible is installed and run the playbook to set up the environment:
ansible-playbook -i inventory playbook.yml
Access the services:
Nginx: Open your browser and navigate to http://<EC2_PUBLIC_IP> to see the "Welcome Imo Bassey" page.
Prometheus: Access Prometheus at http://<EC2_PUBLIC_IP>:9090.
Logstash: Access Logstash at http://<EC2_PUBLIC_IP>:5044.
Elasticsearch: Access Elasticsearch at http://<EC2_PUBLIC_IP>:9200.
Kibana: Access Kibana at http://<EC2_PUBLIC_IP>:5601.