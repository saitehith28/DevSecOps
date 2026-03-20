# Terraform + AWS CLI v2 Setup Guide

## Windows

### Terraform Installation
1. Download: https://developer.hashicorp.com/terraform/downloads  
2. Extract zip → terraform.exe  
3. Move to C:\terraform  
4. Add to PATH: C:\terraform  

Verify:
```powershell
terraform -version
```

---

### AWS CLI v2 Installation
Download: https://awscli.amazonaws.com/AWSCLIV2.msi  

Install and verify:
```powershell
aws --version
```

---

### Configure AWS
```powershell
aws configure
```

---

### Run Terraform
```powershell
terraform init
terraform plan
terraform apply
```

---

## macOS

### Terraform Installation
Install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Terraform:
```bash
brew tap hashicorp/tap
```

```bash
brew install hashicorp/tap/terraform
```

```bash
terraform -install-autocomplete
```

Verify:
```bash
terraform -version
```

---

### AWS CLI v2 Installation
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
```

```bash
sudo installer -pkg AWSCLIV2.pkg -target /
```

Verify:
```bash
aws --version
```

---

### Configure AWS
```bash
aws configure
```

---

### Run Terraform
```bash
terraform init
terraform plan
terraform apply
```

# Run Terraform from AWS EC2 Instance

## Step 1: Create EC2 Instance

- Go to AWS Console → EC2 → Launch Instance  
- AMI → Amazon Linux 2  
- Instance type → t2.micro  
- Create/download key pair (.pem)  
- Allow SSH (port 22)  

---

## Step 2: Connect to EC2

```bash
ssh -i your-key.pem ec2-user@<public-ip>
```

---

## Step 3: Install Terraform

```bash
sudo yum install -y yum-utils
```

```bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```

```bash
sudo yum -y install terraform
```

---

## Step 4: Verify Terraform

```bash
terraform -version
```

---

## Step 5: Configure AWS (Recommended: IAM Role)

### Attach IAM Role to EC2
- Go to EC2 → Instance → Actions → Security → Modify IAM Role  
- Attach role with required permissions (e.g., EC2 access)

### Verify

```bash
aws sts get-caller-identity
```

---

## Step 6: Create Terraform File

```bash
vi main.tf
```

Paste:

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}
```

---

## Step 7: Run Terraform

```bash
terraform init
terraform plan
terraform apply
```

When prompted:

```bash
yes
```

---

## Result

- EC2 instance will be created using Terraform  
- Terraform is executed from inside EC2  

---

## Notes

- IAM Role is preferred over `aws configure`  
- Avoid storing access keys inside EC2  
- Common approach in DevOps and CI/CD pipelines  