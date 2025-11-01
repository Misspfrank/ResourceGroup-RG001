# terraform-ResourceGroup-RG001

Terraform module for creating Azure Resource Groups, with environment-specific configurations and Azure Pipelines integration.

## Overview

This project demonstrates a modular Terraform layout for provisioning Azure Resource Groups using reusable modules and environment folders.

It includes:
- A **Terraform module** (`modules/resource-group`) that defines an Azure Resource Group.
- An **environment configuration** (`environments/dev`) that consumes the module.
- An **Azure Pipelines** workflow (`.azure-pipelines/azure-pipelines.yml`) for CI/CD automation.

## 🧱 Project Structure

terraform-rg/
├── modules/
│ └── resource-group/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│
├── environments/
│ └── dev/
│ ├── main.tf
│ ├── provider.tf
│ ├── variables.tf
│ └── backend.tf # (optional, for remote state)
│
├── .azure-pipelines/
│ └── azure-pipelines.yml
│
├── .gitignore
└── README.md

## ⚙️ Usage

You can use this module locally or reference it from GitHub.

### 🔹 Example — Local usage (from `environments/dev/main.tf`)

module "resource_group" {
  source   = "../../modules/resource-group"
  name     = var.rg_name
  location = var.rg_location
  tags     = var.tags
}

output "resource_group_id" {
  value = module.resource_group.id
}
🔹 Example — Remote usage (from another project)

Copy code

module "resource_group" {
  source   = "github.com/Misspfrank/ResourceGroup-RG001//modules/resource-group"
  name     = "RG001"
  location = "West Europe"
  tags = {
    environment = "dev"
  }
}

Inputs
Name	  Type	           Description	                         Default
name	  string	       Name of the resource group	         n/a
location  string	       Azure region for the RG	             "West Europe"
tags	  map(string)	   Tags to apply to the RG	              {}

Outputs
Name	         Description
id	             Resource Group ID
name	         Resource Group name

Running Terraform locally
1.Authenticate to Azure:
az login
az account set --subscription "<your-subscription-id>"
2.Run Terraform:
cd environments/dev
terraform init
terraform plan
terraform apply
3.(Optional) Destroy resources:
terraform destroy

Remote State (Recommended)
Store your Terraform state in Azure Storage:
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "<your-storage-account-name>"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
See the backend.tf file under environments/dev/ for details.

CI/CD (Azure Pipelines)

The pipeline at .azure-pipelines/azure-pipelines.yml automates:
Installing Terraform
Running terraform init and plan

Before running:
Create an Azure Resource Manager service connection in Azure DevOps.
Replace <<YOUR-AZURE-SERVICE-CONNECTION-NAME>> in the YAML file with your actual connection name.

Useful Commands
Command	             Description
terraform fmt	     Format code
terraform validate	 Check syntax
terraform plan	     Preview changes
terraform apply	     Apply infrastructure
terraform destroy	 Remove infrastructure


Author
Misspfrank
Terraform + Azure Infrastructure Automation
