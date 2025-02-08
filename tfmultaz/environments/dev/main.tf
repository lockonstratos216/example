module "virtual_machine" {
    source               = "C:/Users/viraj/tffiles/tfmultaz/modules/virtual_machine"
    environment          = "dev"
    resource_group_name  = "dev-rg"
    admin_password       = var.admin_password
    location = "Central India"
}