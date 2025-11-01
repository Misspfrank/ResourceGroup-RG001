variable "rg_name" {
    type = string
    description = "The name of the Resource Group."
  
}
variable "location" {
    type = string
    description = "Azure region for the Resource Group."
    default = "westeurope"
  
}
variable "tags" {
    type = map(string)
    description = "A map of tags to assign to the Resource Group."
    default = {}
  
}