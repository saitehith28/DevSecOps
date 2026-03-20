
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