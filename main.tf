locals {
  enabled = module.this.enabled

  create_log_group = local.enabled && (
    (var.vpn_connection_tunnel1_cloudwatch_log_enabled && length(var.vpn_connection_tunnel1_cloudwatch_log_group_arn) == 0) ||
    (var.vpn_connection_tunnel2_cloudwatch_log_enabled && length(var.vpn_connection_tunnel2_cloudwatch_log_group_arn) == 0)
  )
  tunnel1_log_group_arn = try(var.vpn_connection_tunnel1_cloudwatch_log_group_arn[0], module.logs.log_group_arn)
  tunnel2_log_group_arn = try(var.vpn_connection_tunnel2_cloudwatch_log_group_arn[0], module.logs.log_group_arn)

  transit_gateway_enabled    = local.enabled && var.transit_gateway_enabled
  transit_gateway_rt_enabled = local.transit_gateway_enabled && var.transit_gateway_route_table_id != null
  cloudwan_enabled           = local.enabled && var.cloudwan_enabled
  vpn_gateway_enabled        = local.enabled && !var.transit_gateway_enabled && !var.cloudwan_enabled && var.existing_vpn_gateway_id == null

  vpn_gateway_only = var.customer_gateway_ip_address == null

  transit_gateway_attachment_id = one(aws_vpn_connection.default[*].transit_gateway_attachment_id)
  vpn_gateway_id                = local.vpn_gateway_enabled ? one(aws_vpn_gateway.default[*].id) : var.existing_vpn_gateway_id
  customer_gateway_id           = one(aws_customer_gateway.default[*].id)
  customer_gateway_device_name  = var.customer_gateway_device_name == "" ? module.this.id : var.customer_gateway_device_name
  vpn_connection_id             = one(aws_vpn_connection.default[*].id)
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway.html
resource "aws_vpn_gateway" "default" {
  count = local.vpn_gateway_enabled ? 1 : 0

  vpc_id          = var.vpc_id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn
  tags            = module.this.tags
}

# https://www.terraform.io/docs/providers/aws/r/customer_gateway.html
resource "aws_customer_gateway" "default" {
  count = local.enabled && !local.vpn_gateway_only ? 1 : 0

  device_name      = local.customer_gateway_device_name
  bgp_asn          = var.customer_gateway_bgp_asn <= 2147483647 ? var.customer_gateway_bgp_asn : null
  bgp_asn_extended = var.customer_gateway_bgp_asn > 2147483647 ? var.customer_gateway_bgp_asn : null
  ip_address       = var.customer_gateway_ip_address
  type             = "ipsec.1"
  tags             = module.this.tags

  lifecycle {
    create_before_destroy = true
  }
}

module "logs" {
  source  = "cloudposse/cloudwatch-logs/aws"
  version = "0.6.9"

  enabled           = local.create_log_group
  iam_role_enabled  = false
  retention_in_days = var.vpn_connection_log_retention_in_days

  context = module.this.context
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection.html
resource "aws_vpn_connection" "default" {
  count = local.enabled && !local.vpn_gateway_only ? 1 : 0

  vpn_gateway_id           = local.transit_gateway_enabled ? null : local.vpn_gateway_id
  customer_gateway_id      = local.customer_gateway_id
  transit_gateway_id       = local.transit_gateway_enabled ? var.existing_transit_gateway_id : null
  type                     = "ipsec.1"
  enable_acceleration      = var.vpn_acceleration_enabled ? true : null
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
  tunnel1_phase1_lifetime_seconds      = var.vpn_connection_tunnel1_phase1_lifetime_seconds
  tunnel1_phase2_lifetime_seconds      = var.vpn_connection_tunnel1_phase2_lifetime_seconds

  tunnel1_log_options {
    cloudwatch_log_options {
      log_enabled       = var.vpn_connection_tunnel1_cloudwatch_log_enabled
      log_group_arn     = var.vpn_connection_tunnel1_cloudwatch_log_enabled ? local.tunnel1_log_group_arn : null
      log_output_format = var.vpn_connection_tunnel1_cloudwatch_log_enabled ? var.vpn_connection_tunnel1_cloudwatch_log_output_format : null
    }
  }

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
  tunnel2_phase1_lifetime_seconds      = var.vpn_connection_tunnel2_phase1_lifetime_seconds
  tunnel2_phase2_lifetime_seconds      = var.vpn_connection_tunnel2_phase2_lifetime_seconds

  tunnel2_log_options {
    cloudwatch_log_options {
      log_enabled       = var.vpn_connection_tunnel2_cloudwatch_log_enabled
      log_group_arn     = var.vpn_connection_tunnel2_cloudwatch_log_enabled ? local.tunnel2_log_group_arn : null
      log_output_format = var.vpn_connection_tunnel2_cloudwatch_log_enabled ? var.vpn_connection_tunnel2_cloudwatch_log_output_format : null
    }
  }

  tags = module.this.tags
}

# https://www.terraform.io/docs/providers/aws/r/vpn_gateway_route_propagation.html
resource "aws_vpn_gateway_route_propagation" "default" {
  count          = local.enabled && !var.transit_gateway_enabled ? length(var.route_table_ids) : 0
  vpn_gateway_id = local.vpn_gateway_id
  route_table_id = element(var.route_table_ids, count.index)
}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html
resource "aws_vpn_connection_route" "default" {
  count                  = local.enabled && var.vpn_connection_static_routes_only ? length(var.vpn_connection_static_routes_destinations) : 0
  vpn_connection_id      = local.vpn_connection_id
  destination_cidr_block = element(var.vpn_connection_static_routes_destinations, count.index)
}

## Transit Gateway VPN Connection Attachments

# Required to tag VPN Connection TGW Attachments out of bound of the VPN Connection resource
# If we do not do this, the TGW Attachment will not have a name tag or any tags, which makes it difficult to identify in the console.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag
resource "aws_ec2_tag" "default" {
  for_each = local.transit_gateway_enabled ? module.this.tags : {}

  resource_id = local.transit_gateway_attachment_id
  key         = each.key
  value       = each.value
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association
resource "aws_ec2_transit_gateway_route_table_association" "default" {
  count = local.transit_gateway_rt_enabled ? 1 : 0

  transit_gateway_attachment_id  = local.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation
resource "aws_ec2_transit_gateway_route_table_propagation" "default" {
  count = local.transit_gateway_rt_enabled ? 1 : 0

  transit_gateway_attachment_id  = local.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route
resource "aws_ec2_transit_gateway_route" "default" {
  for_each = local.transit_gateway_rt_enabled ? var.transit_gateway_routes : {}

  blackhole                      = each.value.blackhole
  destination_cidr_block         = each.value.destination_cidr_block
  transit_gateway_attachment_id  = local.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

## Cloud WAN VPN Connection Attachments
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkmanager_site_to_site_vpn_attachment
resource "aws_networkmanager_site_to_site_vpn_attachment" "default" {
  count = local.cloudwan_enabled ? 1 : 0

  core_network_id    = var.cloudwan_core_network_id
  vpn_connection_arn = aws_vpn_connection.default.arn
  tags               = module.this.tags
}
