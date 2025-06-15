# Makefile for Terraform K3s Cluster Management

# Default environment (can be overridden: make plan ENV=dev)
ENV ?= prod
VARS_FILE := environments/$(ENV).tfvars

.PHONY: help init plan apply destroy format

help:  ## Show this help message
	@echo ""
	@echo "Terraform K3s Cluster Management 🛠️"
	@echo "-----------------------------------"
	@echo "Usage: make <target> [ENV=prod|dev]"
	@echo ""
	@grep -E '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) | \
		sed -E 's/^([a-zA-Z0-9_-]+):.*?## (.*)/  \1\t\2/' | \
		expand -t 20
	@echo ""
	@echo "Example: make plan ENV=prod"

## Initialize Terraform
init:  ## Initialize Terraform
	@echo "\n💡 Initializing Terraform for $(ENV) environment..."
	terraform init

## Show Terraform plan for the selected environment
plan:  ## Show Terraform plan for the selected environment
	@echo "\n💡 Planning Terraform for $(ENV) environment using $(VARS_FILE)..."
	terraform plan -var-file="$(VARS_FILE)"

## Apply Terraform for the selected environment
apply: ## Apply Terraform for the selected environment
	@echo "\n💡 Applying Terraform for $(ENV) environment using $(VARS_FILE)..."
	terraform apply -var-file="$(VARS_FILE)"

## Destroy Terraform for the selected environment
destroy: ## Destroy the Terraform stack for the selected environment
	@echo "\n💡 Destroying Terraform for $(ENV) environment using $(VARS_FILE)..."
	terraform destroy -var-file="$(VARS_FILE)"

## Format Terraform files in the terraform folder and validate
format: ## Format all Terraform files in the terraform folder and validate
	terraform fmt -recursive .
	terraform validate

