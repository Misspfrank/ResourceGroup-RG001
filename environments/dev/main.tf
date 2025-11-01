module "rg" {
    source   = "../../modules/resource-group"
    rg_name  = "RG001"
    location = "westeurope"
    tags     = {
        environment = "dev"
        owner       = "terraform"
    }
  
}