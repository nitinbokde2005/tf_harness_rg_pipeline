resource_groups = {
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
