# Terraform + AWS CLI v2 Setup Guide

## Windows

### Terraform Installation
1. Download: https://developer.hashicorp.com/terraform/downloads  
2. Extract zip → terraform.exe  
3. Move to C:\terraform  
4. Add to PATH: C:\terraform  

Verify:
terraform -version  

---

### AWS CLI v2 Installation
Download: https://awscli.amazonaws.com/AWSCLIV2.msi  
Install and verify:
aws --version  

---

### Configure AWS
aws configure  

---

### Run Terraform
terraform init  
terraform plan  
terraform apply  

---

## macOS

### Terraform Installation
Install Homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Install Terraform:
brew tap hashicorp/tap  
brew install hashicorp/tap/terraform  

Verify:
terraform -version  

---

### AWS CLI v2 Installation
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"  
sudo installer -pkg AWSCLIV2.pkg -target /  

Verify:
aws --version  

---

### Configure AWS
aws configure  

---

### Run Terraform
terraform init  
terraform plan  
terraform apply  