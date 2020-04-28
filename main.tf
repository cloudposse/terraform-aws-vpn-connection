module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  enabled    = var.enabled
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

locals {
  enabled = var.enabled == "true"
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html
resource "aws_vpn_gateway" "default" {
  count           = local.enabled ? 1 : 0
  vpc_id          = var.vpc_id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn
  tags            = module.label.tags
}

# https://www.terraform.io/docs/providers/aws/r/customer_gateway.html
resource "aws_customer_gateway" "default" {
  count      = local.enabled ? 1 : 0
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip_address
  type       = "ipsec.1"
  tags       = module.label.tags
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection.html
resource "aws_vpn_connection" "default" {
  count                 = local.enabled ? 1 : 0
  vpn_gateway_id        = join("", aws_vpn_gateway.default.*.id)
  customer_gateway_id   = join("", aws_customer_gateway.default.*.id)
  type                  = "ipsec.1"
  static_routes_only    = var.vpn_connection_static_routes_only
  tunnel1_inside_cidr   = var.vpn_connection_tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.vpn_connection_tunnel2_inside_cidr
  tunnel1_preshared_key = var.vpn_connection_tunnel1_preshared_key
  tunnel2_preshared_key = var.vpn_connection_tunnel2_preshared_key
  tags                  = module.label.tags
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
