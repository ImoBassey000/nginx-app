# Clone the repository 
git clone https://github.com/ImoBassey000/nginx-app.git
cd nginx-app

# Create directory structure
mkdir -p app terraform ansible

# Add Nginx sample page
cat <<EOL > app/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to my web page</title>
</head>
<body>
    <h1>Welcome Imo Basseyy</h1>
</body>
</html>
EOL

# Create a Dockerfile
cat <<EOL > Dockerfile
FROM nginx:alpine
COPY app/index.html /usr/share/nginx/html/index.html
EOL

# Add the GitHub Actions pipeline
mkdir -p .github/workflows
touch .github/workflows/ci-cd.yml

cat <<EOL > .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  lint:
    name: Lint Code
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
      - name: Lint Dockerfile
        run: |
          sudo apt-get install -y hadolint
          hadolint Dockerfile

  test:
    name: Run Unit Tests
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
      - name: Run Sample Tests
        run: echo "No tests yet! Add unit tests here."

  build:
    name: Build Application
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
      - name: Build Docker Image
        run: |
          docker build -t nginx-app:latest .

  deploy:
    name: Deploy Application
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
      - name: Set Up Terraform
        uses: hashicorp/setup-terraform@v2
      - name: Initialize Terraform
        run: |
          cd terraform
          terraform init
      - name: Apply Terraform Changes
        run: |
          cd terraform
          terraform apply -auto-approve
EOL


