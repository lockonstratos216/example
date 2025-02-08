module "virtual_machine" {
    source               = "C:/Users/viraj/tffiles/tfmultaz/modules/virtual_machine"
    environment          = "staging"
    resource_group_name  = "staging-rg"
    admin_password       = var.admin_password
}