# Ansible Deployment for Azure VM App Stack

This repository contains an **Ansible playbook** to deploy an application stack on an Azure VM via a Bastion host. It integrates with **Azure Key Vault** to fetch sensitive variables.  

---

# Prerequisites Installation Guide

Before running the Ansible playbooks, you need to install **Azure CLI** and the required **Python libraries** for Azure integration.

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

## 2. Dependencies Installation
The playbooks require Python >= 3.8 and the following libraries:
	•	azure-identity
	•	azure-keyvault-secrets

### Linux / macOS
# Install pip if not installed
```bash
sudo apt update && sudo apt install -y python3-pip  # Linux (Debian/Ubuntu)
brew install python3                               # macOS (Homebrew)

# Install required Python libraries
pip3 install --user azure-identity azure-keyvault-secrets

# Verify installation
python3 -m pip show azure-identity azure-keyvault-secrets
```

## 3. Verify Setup
```bash
az login
```

# 4. Using Existing Azure Key Vault Secrets
We use an existing Azure Key Vault previously created by terraform.
### Setup needed vars in Azure Key Vault
- ansible-user
- ansible_become_pass
- ansible-ssh-pv-key
- postgres-user
- postgres-password
- postgres-db
- keycloak-admin-user
- keycloak-admin-password
- oauth2-client-id
- oauth2-client-secret
- oauth2-cookie-secret
- vm-lb-public-ip

# 5. Passwordless SSH Setup
### Generate an SSH Key Pair
```bash
ssh-keygen -t rsa -b 4096 -C "ansible-demo-key" -f ~/.ssh/id_rsa_ansible
```
### Create secret in Azure Key vault
Tunnel should be open for running this and main playbook.

```bash
az keyvault secret set \
  --vault-name <your-keyvault-name> \
  --name "ansible-ssh-pv-key" \
  --value ~/.ssh/id_rsa_ansible
```
### Open SSH Tunnel to Virtual machine through Bation Instance
```bash
az network bastion tunnel \
  --name <bastion-host-name> \
  --resource-group <resource-group-name> \
  --target-resource-id /subscriptions/<azure subscription ID>/resourceGroups/rg-terraform-state/providers/Microsoft.Compute/virtualMachines/<vm-name> \
  --resource-port 22 \
  --port 10022
```
### Run passwordless playbook
```bash
ansible-playbook -i inventories/hosts.yml passwordless-sudo-playbook.yml -l vm-demo -e "ansible_port=10022"
```

# 6. Run main playbook for provisioning Azure Virtual Machine
```bash
ansible-playbook -i inventories/hosts.yml playbook.yml -l vm-demo -e "ansible_port=10022"
```

