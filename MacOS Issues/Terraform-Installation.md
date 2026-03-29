# Terraform + AWS CLI v2 Setup Guide

## Windows

### Terraform Installation
1. Download: https://developer.hashicorp.com/terraform/downloads  
2. Download AMD64
3. Extract zip → terraform.exe  
4. Move to C:\terraform  
5. Add to PATH: C:\terraform  

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