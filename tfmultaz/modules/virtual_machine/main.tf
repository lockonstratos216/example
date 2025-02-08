resource "azurerm_resource_group" "rg" {
    name      = var.resource_group_name
    location  = "Central-India"
}

resource "azurerm_virtual_network" "vnet" {
    name                   = "vnet-${var.environment}"
    location               = azurerm_resource_group.rg.location
    resource_group_name    = azurerm_resource_group.rg.name
    address_space          = ["13.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    name                 = "subnet-${var.environment}"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["13.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
    name                 = "nic-${var.environment}"
    location             = azurerm_resource_group.rg.location
    resource_group_name  = azurerm_resource_group.rg.name

    ip_configuration {
      name                          = "internal"
      subnet_id                     = azurerm_subnet.subnet.id
      private_ip_address_allocation = "Dynamic"
    }
  
}

resource "azurerm_linux_virtual_machine" "vm" {
    name                        = "vm-${var.environment}"
    location                    = azurerm_resource_group.rg.location 
    resource_group_name         = azurerm_resource_group.rg.name
    size                        = "Standard_B1s"

    admin_username                  = "Azuser"
    admin_password                  = var.admin_password
    disable_password_authentication = false

    network_interface_ids = [azurerm_network_interface.nic.id]

    os_disk {
        caching                   = "ReadWrite"
        storage_account_type      = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  
}