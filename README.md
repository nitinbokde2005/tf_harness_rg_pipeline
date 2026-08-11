# Azure Resource Group Provisioning with Terraform (Multi-Environment Setup)

This Terraform project provisions Azure Resource Groups dynamically across isolated environment directories (`environments/preprod` and `environments/prod`) using a shared, reusable **child module** driven by Terraform's `for_each` meta-argument and `map(object)` data structures.

---

## 📁 Repository Structure

```text
tf_harness_rg_pipeline/
├── modules/
│   └── resource_group/
│       ├── main.tf          # Child module resource definition (for_each over var.resource_groups)
│       ├── variables.tf     # Child module input variable map declaration
│       └── outputs.tf       # Child module outputs (names, IDs, full resource objects)
├── environments/
│   ├── preprod/             # Independent Preprod Environment
│   │   ├── main.tf          # Calls shared child module (../../modules/resource_group)
│   │   ├── variables.tf     # Preprod variable declaration
│   │   ├── terraform.tfvars # Defines 2 preprod RGs (app & db)
│   │   ├── providers.tf     # Provider configuration
│   │   └── outputs.tf       # Preprod environment outputs
│   └── prod/                # Independent Production Environment
│       ├── main.tf          # Calls shared child module (../../modules/resource_group)
│       ├── variables.tf     # Prod variable declaration
│       ├── terraform.tfvars # Defines 2 prod RGs (app & db)
│       ├── providers.tf     # Provider configuration
│       └── outputs.tf       # Prod environment outputs
├── .gitignore               # Git ignore rules for Terraform local state and binary files
└── README.md
```

---

## 🚀 Architectural Overview

### 1. Reusable Child Module (`modules/resource_group`)
The shared child module accepts a map of objects and provisions `azurerm_resource_group` resources dynamically using `for_each`.

- **Input Variable**: `resource_groups` (`map(object({ name = string, location = string, tags = optional(map(string)) }))`)
- **Outputs**:
  - `resource_groups`: Map of full resource objects.
  - `resource_group_names`: Map of created Resource Group names.
  - `resource_group_ids`: Map of created Resource Group IDs.

### 2. Isolated Environments
Each environment (`environments/preprod` and `environments/prod`) operates independently with its own state file, provider configurations, and `terraform.tfvars`.

---

## 🛠️ Deployment Instructions

### Prerequisites
- [Terraform](https://www.terraform.io/downloads) `v1.5.0` or higher.
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) logged in (`az login`).

### Deploying Preprod Environment

1. Navigate to the `preprod` environment folder:
   ```bash
   cd environments/preprod
   ```

2. Initialize and Apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

---

### Deploying Prod Environment

1. Navigate to the `prod` environment folder:
   ```bash
   cd environments/prod
   ```

2. Initialize and Apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

---

## 📤 Outputs Example.

### Preprod Output (`environments/preprod`):
```hcl
preprod_resource_groups = {
  "app" = "rg-preprod-app-eastus"
  "db"  = "rg-preprod-db-eastus"
}
```

### Prod Output (`environments/prod`):
```hcl
prod_resource_groups = {
  "app" = "rg-prod-app-eastus"
  "db"  = "rg-prod-db-eastus"
}
``````
