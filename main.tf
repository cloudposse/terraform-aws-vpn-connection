locals {
  enabled = module.this.enabled
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html
resource "aws_vpn_gateway" "default" {
  count           = local.enabled ? 1 : 0
  vpc_id          = var.vpc_id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn
  tags            = module.this.tags
}

# https://www.terraform.io/docs/providers/aws/r/customer_gateway.html
resource "aws_customer_gateway" "default" {
  count      = local.enabled ? 1 : 0
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip_address
  type       = "ipsec.1"
  tags       = module.this.tags
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection.html
resource "aws_vpn_connection" "default" {
  count                    = local.enabled ? 1 : 0
  vpn_gateway_id           = join("", aws_vpn_gateway.default.*.id)
  customer_gateway_id      = join("", aws_customer_gateway.default.*.id)
  type                     = "ipsec.1"
  static_routes_only       = var.vpn_connection_static_routes_only
  local_ipv4_network_cidr  = var.vpn_connection_local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.vpn_connection_remote_ipv4_network_cidr

  tunnel1_dpd_timeout_action = var.vpn_connection_tunnel1_dpd_timeout_action
  tunnel1_ike_versions       = var.vpn_connection_tunnel1_ike_versions
  tunnel1_inside_cidr        = var.vpn_connection_tunnel1_inside_cidr
  tunnel1_preshared_key      = var.vpn_connection_tunnel1_preshared_key
  tunnel1_startup_action     = var.vpn_connection_tunnel1_startup_action

  tunnel1_phase1_dh_group_numbers      = var.vpn_connection_tunnel1_phase1_dh_group_numbers
  tunnel1_phase2_dh_group_numbers      = var.vpn_connection_tunnel1_phase2_dh_group_numbers
  tunnel1_phase1_encryption_algorithms = var.vpn_connection_tunnel1_phase1_encryption_algorithms
  tunnel1_phase2_encryption_algorithms = var.vpn_connection_tunnel1_phase2_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.vpn_connection_tunnel1_phase1_integrity_algorithms
  tunnel1_phase2_integrity_algorithms  = var.vpn_connection_tunnel1_phase2_integrity_algorithms

  tunnel2_dpd_timeout_action = var.vpn_connection_tunnel2_dpd_timeout_action
  tunnel2_ike_versions       = var.vpn_connection_tunnel2_ike_versions
  tunnel2_inside_cidr        = var.vpn_connection_tunnel2_inside_cidr
  tunnel2_preshared_key      = var.vpn_connection_tunnel2_preshared_key
  tunnel2_startup_action     = var.vpn_connection_tunnel2_startup_action

  tunnel2_phase1_dh_group_numbers      = var.vpn_connection_tunnel2_phase1_dh_group_numbers
  tunnel2_phase2_dh_group_numbers      = var.vpn_connection_tunnel2_phase2_dh_group_numbers
  tunnel2_phase1_encryption_algorithms = var.vpn_connection_tunnel2_phase1_encryption_algorithms
  tunnel2_phase2_encryption_algorithms = var.vpn_connection_tunnel2_phase2_encryption_algorithms
  tunnel2_phase1_integrity_algorithms  = var.vpn_connection_tunnel2_phase1_integrity_algorithms
  tunnel2_phase2_integrity_algorithms  = var.vpn_connection_tunnel2_phase2_integrity_algorithms

  tags = module.this.tags
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html
resource "aws_vpn_gateway_route_propagation" "default" {
  count          = local.enabled ? length(var.route_table_ids) : 0
  vpn_gateway_id = join("", aws_vpn_gateway.default.*.id)
  route_table_id = element(var.route_table_ids, count.index)
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html
resource "aws_vpn_connection_route" "default" {
  count                  = local.enabled && var.vpn_connection_static_routes_only == "true" ? length(var.vpn_connection_static_routes_destinations) : 0
  vpn_connection_id      = join("", aws_vpn_connection.default.*.id)
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}
