output "vpn_gateway_id" {
  description = "Virtual Private Gateway ID"
  value       = local.vpn_gateway_id
}

output "customer_gateway_id" {
  description = "Customer Gateway ID"
  value       = local.customer_gateway_id
}

output "vpn_connection_id" {
  description = "VPN Connection ID"
  value       = local.vpn_connection_id
}

output "vpn_connection_customer_gateway_configuration" {
  description = "The configuration information for the VPN connection's Customer Gateway (in the native XML format)"
  sensitive   = true
  value       = join("", aws_vpn_connection.default[*].customer_gateway_configuration)
}

output "vpn_connection_tunnel1_address" {
  description = "The public IP address of the first VPN tunnel"
  value       = join("", aws_vpn_connection.default[*].tunnel1_address)
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway side)"
  value       = join("", aws_vpn_connection.default[*].tunnel1_cgw_inside_address)
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Virtual Private Gateway side)"
  value       = join("", aws_vpn_connection.default[*].tunnel1_vgw_inside_address)
}

output "vpn_connection_tunnel2_address" {
  description = "The public IP address of the second VPN tunnel"
  value       = join("", aws_vpn_connection.default[*].tunnel2_address)
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway side)"
  value       = join("", aws_vpn_connection.default[*].tunnel2_cgw_inside_address)
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Virtual Private Gateway side)"
  value       = join("", aws_vpn_connection.default[*].tunnel2_vgw_inside_address)
}

output "transit_gateway_attachment_id" {
  description = "The ID of the transit gateway attachment for the VPN connection (if a TGW connection)"
  value       = local.transit_gateway_attachment_id
}
