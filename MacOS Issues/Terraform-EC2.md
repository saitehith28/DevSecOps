
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

## Step 4: Configure AWS
```bash
aws configure
```
## Step 6: Run Terraform

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