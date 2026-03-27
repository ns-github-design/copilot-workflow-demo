# Virtual Network
resource "azurerm_virtual_network" "main" {
    name                = var.vnet_name
    address_space       = var.address_space
    location            = var.location
    resource_group_name = var.resource_group_name
}

# Subnet
resource "azurerm_subnet" "main" {
    name                 = var.subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = var.subnet_address_prefixes
}

# Network Security Group
resource "azurerm_network_security_group" "main" {
    name                = var.nsg_name
    location            = var.location
    resource_group_name = var.resource_group_name
}

# NSG Rule (example for HTTP)
resource "azurerm_network_security_rule" "allow_http" {
    name                        = "AllowHTTP"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.main.name
}

# Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "main" {
    subnet_id                 = azurerm_subnet.main.id
    network_security_group_id = azurerm_network_security_group.main.id
}

# Route Table
resource "azurerm_route_table" "main" {
    name                = var.route_table_name
    location            = var.location
    resource_group_name = var.resource_group_name
}

# Route (example)
resource "azurerm_route" "main" {
    name                   = "DefaultRoute"
    resource_group_name    = var.resource_group_name
    route_table_name       = azurerm_route_table.main.name
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
}

# Associate Route Table with Subnet
resource "azurerm_subnet_route_table_association" "main" {
    subnet_id      = azurerm_subnet.main.id
    route_table_id = azurerm_route_table.main.id
}