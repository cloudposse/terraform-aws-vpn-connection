output "vpn_gateway_id" {
  description = "Virtual Private Gateway ID"
  value       = local.vpn_gateway_id
}

output "customer_gateway_id" {
  description = "Customer Gateway ID"
  value       = local.customer_gateway_id
}

output "customer_gateway_device_name" {
  description = "Customer Gateway Device Name"
  value       = one(aws_customer_gateway.default[*].device_name)
}

output "vpn_connection_id" {
  description = "VPN Connection ID"
  value       = local.vpn_connection_id
}

output "vpn_connection_customer_gateway_configuration" {
  description = "The configuration information for the VPN connection's Customer Gateway (in the native XML format)"
  sensitive   = true
  value       = one(aws_vpn_connection.default[*].customer_gateway_configuration)
}

output "vpn_connection_tunnel1_address" {
  description = "The public IP address of the first VPN tunnel"
  value       = one(aws_vpn_connection.default[*].tunnel1_address)
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway side)"
  value       = one(aws_vpn_connection.default[*].tunnel1_cgw_inside_address)
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Virtual Private Gateway side)"
  value       = one(aws_vpn_connection.default[*].tunnel1_vgw_inside_address)
}

output "vpn_connection_tunnel1_log_group_arn" {
  description = "The CloudWatch Log Group ARN for the tunnel 1 logs"
  value       = var.vpn_connection_tunnel1_cloudwatch_log_enabled ? one(aws_vpn_connection.default[*].tunnel1_log_options[0].cloudwatch_log_options[0].log_group_arn) : null
}

output "vpn_connection_tunnel2_address" {
  description = "The public IP address of the second VPN tunnel"
  value       = one(aws_vpn_connection.default[*].tunnel2_address)
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway side)"
  value       = one(aws_vpn_connection.default[*].tunnel2_cgw_inside_address)
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Virtual Private Gateway side)"
  value       = one(aws_vpn_connection.default[*].tunnel2_vgw_inside_address)
}

output "vpn_connection_tunnel2_log_group_arn" {
  description = "The CloudWatch Log Group ARN for the tunnel 2 logs"
  value       = var.vpn_connection_tunnel2_cloudwatch_log_enabled ? one(aws_vpn_connection.default[*].tunnel2_log_options[0].cloudwatch_log_options[0].log_group_arn) : null
}

output "transit_gateway_attachment_id" {
  description = "The ID of the transit gateway attachment for the VPN connection (if a TGW connection)"
  value       = local.transit_gateway_attachment_id
}

output "vpn_acceleration_enabled" {
  description = "Whether the VPN connection is enabled for acceleration"
  value       = one(aws_vpn_connection.default[*].enable_acceleration)
}
