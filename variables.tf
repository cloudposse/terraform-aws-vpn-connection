variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to which the Virtual Private Gateway will be attached"
}

variable "vpn_gateway_amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the VPN gateway. If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN"
  default     = 64512
}

variable "customer_gateway_bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)"
  default     = 65000
}

variable "customer_gateway_ip_address" {
  type        = string
  description = "The IP address of the gateway's Internet-routable external interface"
}

variable "route_table_ids" {
  type        = list(string)
  description = "The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated"
  default     = []
}

variable "vpn_connection_static_routes_only" {
  type        = string
  description = "If set to `true`, the VPN connection will use static routes exclusively. Static routes must be used for devices that don't support BGP"
  default     = "true"
}

variable "vpn_connection_static_routes_destinations" {
  type        = list(string)
  description = "List of CIDR blocks to be used as destination for static routes. Routes to destinations will be propagated to the route tables defined in `route_table_ids`"
  default     = []
}

variable "vpn_connection_tunnel1_inside_cidr" {
  type        = string
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel"
  default     = null
}

variable "vpn_connection_tunnel2_inside_cidr" {
  type        = string
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel"
  default     = null
}

variable "vpn_connection_tunnel1_preshared_key" {
  type        = string
  description = "The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_)"
  default     = null
}

variable "vpn_connection_tunnel2_preshared_key" {
  type        = string
  description = "The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_)"
  default     = null
}

