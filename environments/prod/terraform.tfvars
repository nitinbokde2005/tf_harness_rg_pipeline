resource_groups = {
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
