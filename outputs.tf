output "vpn_gateway_id" {
  description = "Virtual Private Gateway ID"
  value       = join("", aws_vpn_gateway.default.*.id)
}

output "customer_gateway_id" {
  description = "Customer Gateway ID"
  value       = join("", aws_customer_gateway.default.*.id)
}

output "vpn_connection_id" {
  description = "VPN Connection ID"
  value       = join("", aws_vpn_connection.default.*.id)
}

output "vpn_connection_customer_gateway_configuration" {
  description = "The configuration information for the VPN connection's Customer Gateway (in the native XML format)"
  value = join(
    "",
    aws_vpn_connection.default.*.customer_gateway_configuration,
  )
}

output "vpn_connection_tunnel1_address" {
  description = "The public IP address of the first VPN tunnel"
  value       = join("", aws_vpn_connection.default.*.tunnel1_address)
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway side)"
  value       = join("", aws_vpn_connection.default.*.tunnel1_cgw_inside_address)
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Virtual Private Gateway side)"
  value       = join("", aws_vpn_connection.default.*.tunnel1_vgw_inside_address)
}

output "vpn_connection_tunnel2_address" {
  description = "The public IP address of the second VPN tunnel"
  value       = join("", aws_vpn_connection.default.*.tunnel2_address)
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway side)"
  value       = join("", aws_vpn_connection.default.*.tunnel2_cgw_inside_address)
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Virtual Private Gateway side)"
  value       = join("", aws_vpn_connection.default.*.tunnel2_vgw_inside_address)
}

output "vpn_transit_gateway_attachment_id" {
  description = "Transit Gateway Attachment ID if it's enabled"
  value       = var.transit_gateway_enabled ? join("", aws_vpn_connection.default.*.transit_gateway_attachment_id) : null
}
