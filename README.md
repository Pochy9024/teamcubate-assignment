# Azure Virtual Machine Deployment Assigment
# Prerequisites Note
Before running any workflows, make sure the following GitHub secrets are configured:
	•	AZURE_CLIENT_ID
	•	AZURE_CREDENTIALS
	•	AZURE_SUBSCRIPTION_ID
	•	AZURE_TENANT_ID
	•	AZURE_VM_PRIVATE_SSH_KEY
	•	AZURE_VM_PUBLIC_SSH_KEY
	•	BASTION_HOST_NAME
	•	BASTION_RG_NAME
	•	TF_CONTAINER_NAME
	•	TF_RG_NAME
	•	TF_STORAGE_ACCOUNT
	•	TF_VAR_LOCATION
	•	TF_VAR_RESOURCE_GROUP_NAME
	•	VM_NAME
	•	VM_RG_NAME

Important: The Terraform backend storage (storage account and container) must exist before running the main infrastructure stack. This is required so that the Key Vault and main VM stack can use remote state storage.

## Project Summary
This project automates the provisioning and deployment of an application stack on Azure using Terraform and Ansible. The stack integrates an Nginx server for a static website, Keycloak for authentication (using PostgreSQL DB), a bastion host for secure access, and containerized application services via Docker for consistent environments and simplified deployments.

The infrastructure lifecycle is managed through three GitHub workflows for Terraform—one to deploy the infrastructure, one to destroy it—and a workflow for provisioning the VM with Ansible, enabling automated configuration and application deployment. The project is designed with extensibility, security, and observability in mind.

## Architecture Overview
### 1.	Virtual Network (VNet)
	•	A single VNet provides isolated networking for the project. All resources are deployed inside this network to enforce security and control traffic flow.
### 2.	Subnets
#### Bastion Subnet:
	•	Hosts the Bastion VM to allow secure SSH access to our main Virtual Machine without exposing it to the public internet.
	•	Protected by its own Network Security Group (NSG) allowing only necessary ports (SSH, management).
#### Virtual Machine Subnet:
	•	Hosts the project main Virtual Machine running the stack(Nginx, Oauth2, Keycloak, postgreSQL).
	•	Secured with a separate NSG to restrict inbound traffic.
	•	Traffic to the VM is controlled via the Load Balancer and NAT Gateway.
### 3.	Load Balancer
	•	Exposes the main VM on port 80 to the public internet.
	•	Ensures traffic distribution and can be extended to multiple VMs in the future.
### 4.	NAT Gateway
	•	Provides internet egress for the VM while keeping it private.
	•	Ensures the VM can download updates or access external services without exposing it directly to the public internet.
### 5.	Network Security Groups (NSGs)
	•	Applied at subnet level to control inbound and outbound traffic.
	•	Each subnet has rules tailored to its purpose (Bastion access vs application traffic).
### Key Points:
	•	Bastion host allows secure SSH without exposing the VM.
	•	Load Balancer handles public traffic while NSGs restrict access.
	•	NAT Gateway enables private VMs to reach the internet safely.
	•	Separation of subnets and NSGs enforces strong security boundaries.

## Container Environment (Docker)
### Why Docker:
	•	Provides consistent environments across local development, staging, and production.
	•	Simplifies deployment and dependency management.
	•	Isolates application services from the host OS, increasing security.
### Why not other approaches:
	•	Kubernetes (k8s): Overkill for a single VM setup and small-scale environment
    •	Containerd / CRI-O: Chosen Docker for simplicity and existing ecosystem support

## Images Used
	•	Standard Docker images for services (Nginx, OAuth2 Proxy, Keycloak).
        • quay.io/keycloak/keycloak:21.1.1
        • nginx:latest
        • quay.io/oauth2-proxy/oauth2-proxy:v7.5.0
        • postgres:16
### Why:
	•	Pre-built, trusted, and maintained images reduce build and maintenance overhead.
	•	Enables faster deployment and easier upgrades.

## Network Configuration
### Choice: 
    •   Separate subnets + NSGs + Load Balancer + NAT Gateway
### Why:
#### 1.	Separate Subnets (Bastion & VM):
	    •	Reason: Isolates management traffic (SSH via Bastion) from application traffic. Azure require a separate subnet for BASION.
	    •	Alternative: Single subnet for both Bastion and VMs would simplify setup but increase security risk, as any exposed service could become a pivot point for attackers.
#### 2.	Network Security Groups (NSGs):
	    •	Reason: Provides granular control over inbound and outbound traffic for each subnet.
	    •	Benefit: Only required ports are exposed (e.g., port 80 for the app, port 22 via Bastion).
	    •	Alternative: No NSGs or overly permissive rules would make the environment vulnerable to attacks. Using 1 NSG for all subnets reduce flexibility and granularity.
#### 3.	Load Balancer:
	    •	Reason: Handles incoming HTTP traffic and distributes it to the VM.
	    •	Benefit: Avoids exposing the VM directly to the internet, allows for scaling in the future, and provides a single entry point for monitoring and logging.
	    •	Alternative: Direct public IP on the VM is simpler but less secure and harder to manage at scale.
#### 4.	NAT Gateway:
	    •	Reason: Enables outbound internet access from the VM for updates or API calls, without giving the VM a public IP.
	    •	Benefit: Preserves security while allowing controlled egress traffic.
	    •	Alternative: Public IP on VM would increase attack surface; VPN-only access would restrict internet-dependent operations.
### Summary: 
        •   This configuration balances security, scalability, and manageability. It isolates critical management access, protects application servers, and allows controlled internet connectivity while keeping a clean architecture suitable for future expansion.

## Possible Features and Extensions
### 1.	High Availability (HA):
	    •	Implementation: Deploy multiple VMs across Availability Zones or Regions, possibly behind the existing Load Balancer.
	    •	Benefit: Ensures the application remains accessible even if one VM or zone goes down, increasing resilience and uptime.
### 2.	VM Scale Set:
	    •	Implementation: Use Azure Virtual Machine Scale Sets (VMSS) to automatically scale the number of VMs based on demand.
	    •	Benefit: Provides automatic scaling to handle peak loads efficiently, optimizing costs during low usage periods.
### 3.	Enhanced Security Hardening:
	    •	Implementation:
	        •	Enable Azure Defender / Security Center.
	        •	Enforce Just-In-Time (JIT) VM access via Bastion.
            •	Apply stricter NSG rules, network segmentation, and endpoint security.
	        •	Improve RBAC and IAM policies by creating least-privilege roles for users and services, ensuring controlled access to Azure resources.
	    •	Benefit: Reduces attack surface, protects sensitive data, prevents privilege escalation, and ensures compliance with organizational policies.
### 4.	Observability and Monitoring:
	    •	Implementation: 
            •   Integrate Azure Monitor, Log Analytics, and Grafana/Prometheus for real-time metrics, alerts, and dashboards.
            •   Use VNET flow logs instead of Subnet flow logs.
	    •	Benefit: Provides insights into application and infrastructure health, allows proactive incident management, and facilitates debugging.
### 5.	Backup and Disaster Recovery (DR):
	    •	Implementation: Use Azure Backup for VM snapshots and configure a recovery plan for critical workloads.
	    •	Benefit: Ensures data and application state can be restored quickly in case of failures or accidental deletion.
### 6.	Container Orchestration:
	    •	Implementation: Orchestrate with Kubernetes or Azure Container Apps.
	    •	Benefit: Improves portability, simplifies deployment of multi-service apps, and enables better resource utilization.
### 7.	Centralized Secrets Management:
	    •	Implementation: Use Azure Key Vault for all credentials, API keys, and certificates.
	    •	Benefit: Improves security posture by avoiding secrets in code or configuration files, and allows controlled access and rotation.
### 8.	Web Application Firewall (WAF) Integration:
	    •	Implementation: Enable WAF on the Load Balancer or Application Gateway.
	    •	Benefit: Provides protection against common web attacks like SQL injection, XSS, and bots, increasing overall security.
