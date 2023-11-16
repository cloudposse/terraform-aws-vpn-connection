locals {
  enabled = module.this.enabled
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html
resource "aws_vpn_gateway" "default" {
  count           = var.vpn_gateway_id != null ? 0 : (local.enabled ? 1 : 0)
  vpc_id          = var.vpc_id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn
  tags            = module.this.tags
}

# https://www.terraform.io/docs/providers/aws/r/customer_gateway.html
resource "aws_customer_gateway" "default" {
  count      = local.enabled && var.customer_gateway_id == null ? 1 : 0
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip_address
  type       = "ipsec.1"
  tags = merge(
    module.this.tags,
    var.customer_gateway_name_override != null ? { Name = var.customer_gateway_name_override } : {},
    { ip = var.customer_gateway_ip_address }
  )
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection.html
resource "aws_vpn_connection" "default" {
  count                    = local.enabled ? 1 : 0
  vpn_gateway_id           = var.vpn_gateway_id != null ? var.vpn_gateway_id : join("", aws_vpn_gateway.default.*.id)
  customer_gateway_id      = var.customer_gateway_id == null ? join("", aws_customer_gateway.default.*.id) : var.customer_gateway_id
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

  tunnel1_log_options {
    cloudwatch_log_options {
      log_enabled = var.vpn_tunnel_logging
      log_group_arn = aws_cloudwatch_log_group.tunnel1[0].arn
      log_output_format = "json"
    }
  }

  tunnel2_log_options {
    cloudwatch_log_options {
      log_enabled = var.vpn_tunnel_logging
      log_group_arn = aws_cloudwatch_log_group.tunnel2[0].arn
      log_output_format = "json"
    }
  }

  tags = module.this.tags
}

resource "aws_cloudwatch_log_group" "tunnel1" {
  count = local.enabled && var.vpn_tunnel_logging ? 1 : 0
  name = "/aws/vpn/${terraform.workspace}-${var.name}-tunnel1"
  retention_in_days = var.vpn_tunnel_logging_retention
}

resource "aws_cloudwatch_log_group" "tunnel2" {
  count = local.enabled && var.vpn_tunnel_logging ? 1 : 0
  name = "/aws/vpn/${terraform.workspace}-${var.name}-tunnel2"
  retention_in_days = var.vpn_tunnel_logging_retention
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html
resource "aws_vpn_gateway_route_propagation" "default" {
  count          = local.enabled ? length(var.route_table_ids) : 0
  vpn_gateway_id = var.vpn_gateway_id != null ? var.vpn_gateway_id : join("", aws_vpn_gateway.default.*.id)
  route_table_id = element(var.route_table_ids, count.index)
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html
resource "aws_vpn_connection_route" "default" {
  count                  = local.enabled && var.vpn_connection_static_routes_only == "true" ? length(var.vpn_connection_static_routes_destinations) : 0
  vpn_connection_id      = join("", aws_vpn_connection.default.*.id)
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}
