# Terraform Deployment for Azure VM Infrastructure

This repository contains Terraform scripts to provision Azure infrastructure for an application stack. It creates virtual networks, subnets, VMs, and other resources needed to run your environment.
---

# Prerequisites Installation Guide

Before running the Terraform scripts, you need to install Terraform, Azure CLI, and configure an Azure Service Principal for authentication.

---

## 1. Azure CLI Installation

### Linux (Debian/Ubuntu)
```bash
# Update repository
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify installation
az version
```

### macOS (Homebrew)
```bash
# Install Azure CLI
brew update && brew install azure-cli

# Verify installation
az version
```

## 2. Terraform Installation

### Linux
```bash
# Download Terraform 1.13.1
wget https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_amd64.zip

# Unzip the downloaded file
unzip terraform_1.13.1_linux_amd64.zip

# Move the Terraform binary to a directory included in your system's PATH
sudo mv terraform /usr/local/bin/
```

### macOS
```bash
# Install Terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## 3. Verify Installation
```bash
terraform version
```

# 4. Service Principal and variables
Terraform requires a Service Principal to authenticate with Azure. Ensure it has all require roles and permissions.

### Setup needed vars (.tfvars)
- subscription_id
- ssh_public_key
- location
- resource_group_name (for storage)

# 5. Setup backend
### Initialize Storage for state backend
```bash
cd state-storage
terraform init
terraform plan --out PLAN (-var-file="common.tfvars")
terraform apply PLAN
```

# 6. Setup Key Vault
### Create Key Vault for ansible secrets
```bash
cd key-vault
terraform init
terraform plan --out PLAN (-var-file="common.tfvars")
terraform apply PLAN
```

# 6. Setup Virtual Machine Stack
```bash
cd vm-stack
terraform init
terraform plan --out PLAN (-var-file="common.tfvars")
terraform apply PLAN
```

