# Azure Resource Group Provisioning with Terraform (Preprod & Prod)

This Terraform project provisions Azure Resource Groups dynamically for multiple environments (`preprod` and `prod`) using a reusable **child module** driven by Terraform's `for_each` meta-argument and `map(object)` data structures.

---

## 📁 Repository Structure

```text
tf_harness_rg_pipeline/
├── modules/
│   └── resource_group/
│       ├── main.tf          # Child module resource definition (for_each over var.resource_groups)
│       ├── variables.tf     # Child module input variable map declaration
│       └── outputs.tf       # Child module outputs (names, IDs, full resource objects)
├── .gitignore               # Git ignore rules for Terraform local state and binary files
├── main.tf                  # Root module instantiating resource_group child module for preprod & prod
├── outputs.tf               # Root module outputs exposing created RG names per environment
├── providers.tf             # Terraform & AzureRM provider configuration (~> 5.0)
├── terraform.tfvars         # Input variable values defining 2 RGs per environment
└── variables.tf             # Root module variable declarations
```

---

## 🚀 Architectural Overview

### 1. Child Module (`modules/resource_group`)
The child module accepts a map of objects and provisions `azurerm_resource_group` resources dynamically using `for_each`.

- **Input Variable**: `resource_groups` (`map(object({ name = string, location = string, tags = optional(map(string)) }))`)
- **Outputs**:
  - `resource_groups`: Map of full resource objects.
  - `resource_group_names`: Map of created Resource Group names.
  - `resource_group_ids`: Map of created Resource Group IDs.

### 2. Multi-Environment Provisioning
The root `main.tf` invokes the child module twice:
- `module.preprod_resource_groups`: Provisions preprod environment Resource Groups.
- `module.prod_resource_groups`: Provisions production environment Resource Groups.

---

## 📋 Input Configuration Example (`terraform.tfvars`)

```hcl
preprod_resource_groups = {
  app = {
    name     = "rg-preprod-app-eastus"
    location = "eastus"
    tags = {
      environment = "preprod"
      tier        = "app"
      managed_by  = "terraform"
    }
  }
  db = {
    name     = "rg-preprod-db-eastus"
    location = "eastus"
    tags = {
      environment = "preprod"
      tier        = "db"
      managed_by  = "terraform"
    }
  }
}

prod_resource_groups = {
  app = {
    name     = "rg-prod-app-eastus"
    location = "eastus"
    tags = {
      environment = "prod"
      tier        = "app"
      managed_by  = "terraform"
    }
  }
  db = {
    name     = "rg-prod-db-eastus"
    location = "eastus"
    tags = {
      environment = "prod"
      tier        = "db"
      managed_by  = "terraform"
    }
  }
}
```

---

## 🛠️ Usage Instructions

### Prerequisites
- [Terraform](https://www.terraform.io/downloads) `v1.5.0` or higher.
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) logged in (`az login`).

### Step-by-Step Deployment

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Format and Validate Code**:
   ```bash
   terraform fmt -recursive
   terraform validate
   ```

3. **Preview Infrastructure Plan**:
   ```bash
   terraform plan
   ```

4. **Apply Changes**:
   ```bash
   terraform apply
   ```

---

## 📤 Outputs

After running `terraform apply`, the created Resource Groups are output per environment:

```hcl
preprod_resource_groups = {
  "app" = "rg-preprod-app-eastus"
  "db"  = "rg-preprod-db-eastus"
}

prod_resource_groups = {
  "app" = "rg-prod-app-eastus"
  "db"  = "rg-prod-db-eastus"
}
```
