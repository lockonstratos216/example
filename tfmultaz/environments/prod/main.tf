module "virtual_machine" {
    source               = "C:/Users/viraj/tffiles/tfmultaz/modules/virtual_machine"
    environment          = "prod"
    resource_group_name  = "prod-rg"
    admin_password       = var.admin_password
}