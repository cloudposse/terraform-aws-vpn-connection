variable "vpc_id" {
  type        = string
  description = <<-EOT
    The ID of the VPC to which the Virtual Private Gateway will be attached.
    Not needed if attaching the VPN connection to a Transit Gateway.
    EOT
  default     = null
}

variable "vpn_gateway_amazon_side_asn" {
  type        = number
  description = <<-EOT
    The Autonomous System Number (ASN) for the Amazon side of the VPN gateway.
    If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN.
    EOT
  default     = 64512
  nullable    = false
}

variable "customer_gateway_device_name" {
  type        = string
  description = <<-EOT
    The Device Name of the Customer Gateway. Set to `null` to leave unnamed.
    WARNING: Changing this value will cause the Customer Gateway to be replaced.
    EOT
  default     = ""
  // Allow null for backward compatibility, because setting/changing the name causes the gateway to be replaced
}

variable "customer_gateway_bgp_asn" {
  type        = number
  description = "The Customer Gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)"
  default     = 65000
  nullable    = false
}

variable "customer_gateway_ip_address" {
  type        = string
  description = <<-EOT
    The Internet-routable IP address of the Customer Gateway's external interface.
    WARNING: If set to `null`, the module will not create a Customer Gateway *or a VPN connection*
    and will only create a VPN Gateway.
    EOT
  default     = null
}

variable "route_table_ids" {
  type        = list(string)
  description = "The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated"
  default     = []
  nullable    = false
}

variable "vpn_connection_static_routes_only" {
  type        = bool
  description = <<-EOT
    If set to `true`, the VPN connection will use static routes exclusively.
    Static routes must be used for devices that don't support BGP.
    EOT
  default     = false
  nullable    = false
}

variable "vpn_connection_static_routes_destinations" {
  type        = list(string)
  description = <<-EOT
    List of CIDR blocks to be used as destination for static routes.
    Routes to destinations will be propagated to the route tables defined in `route_table_ids`.
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_local_ipv4_network_cidr" {
  type        = string
  description = "The IPv4 CIDR on the Customer Gateway (on-premises) side of the VPN connection"
  default     = "0.0.0.0/0"
}

variable "vpn_connection_remote_ipv4_network_cidr" {
  type        = string
  description = "The IPv4 CIDR on the AWS side of the VPN connection"
  default     = "0.0.0.0/0"
}

variable "vpn_connection_log_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events"
  default     = 30
  nullable    = false
}

variable "vpn_connection_tunnel1_dpd_timeout_action" {
  type        = string
  description = <<-EOT
    The action to take after DPD timeout occurs for the first VPN tunnel.
    Specify `restart` to restart the IKE initiation. Specify `clear` to end the IKE session.
    Valid values are `clear` | `none` | `restart`
    EOT
  default     = "clear"
  nullable    = false
}

variable "vpn_connection_tunnel1_ike_versions" {
  type        = list(string)
  description = "The IKE versions that are permitted for the first VPN tunnel. Valid values are `ikev1` | `ikev2`"
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_inside_cidr" {
  type        = string
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel"
  default     = null
}

variable "vpn_connection_tunnel1_phase1_encryption_algorithms" {
  type        = list(string)
  description = <<-EOT
    List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations.
    Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_phase2_encryption_algorithms" {
  type        = list(string)
  description = <<-EOT
    List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations.
    Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_phase1_integrity_algorithms" {
  type        = list(string)
  description = <<-EOT
    One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations.
    Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_phase2_integrity_algorithms" {
  type        = list(string)
  description = <<-EOT
    One or more integrity algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations.
    Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_phase1_dh_group_numbers" {
  type        = list(string)
  description = <<-EOT
    List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations.
    Valid values are 2 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_phase2_dh_group_numbers" {
  type        = list(string)
  description = <<-EOT
    List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations.
    Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_phase1_lifetime_seconds" {
  type        = string
  description = "The lifetime for phase 1 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 28800"
  default     = "28800"
  nullable    = false
}

variable "vpn_connection_tunnel1_phase2_lifetime_seconds" {
  type        = string
  description = "The lifetime for phase 2 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 3600"
  default     = "3600"
  nullable    = false
}

variable "vpn_connection_tunnel1_preshared_key" {
  type        = string
  description = "The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_)"
  default     = null
}

variable "vpn_connection_tunnel1_startup_action" {
  type        = string
  description = "The action to take when the establishing the tunnel for the first VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are `add` | `start`"
  default     = "add"
  nullable    = false
}

variable "vpn_connection_tunnel1_cloudwatch_log_enabled" {
  type        = bool
  description = "Enable or disable VPN tunnel logging feature for the tunnel"
  default     = false
  nullable    = false
}

variable "vpn_connection_tunnel1_cloudwatch_log_group_arn" {
  type        = list(string)
  description = <<-EOT
    The ARN of the CloudWatch log group to which the logs will be published.
    If the list is empty and `vpn_connection_tunnel1_cloudwatch_log_enabled` is `true`,
    the module will create a new log group and use it.
    If the list is not empty, the module will use the first ARN in the list.
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel1_cloudwatch_log_output_format" {
  type        = string
  description = "Set log format for the tunnel. Default format is json. Possible values are `json` and `text`"
  default     = "json"
  nullable    = false
}

variable "vpn_connection_tunnel2_dpd_timeout_action" {
  type        = string
  description = "The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are `clear` | `none` | `restart`"
  default     = "clear"
  nullable    = false
}

variable "vpn_connection_tunnel2_ike_versions" {
  type        = list(string)
  description = "The IKE versions that are permitted for the second VPN tunnel. Valid values are `ikev1` | `ikev2`"
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_inside_cidr" {
  type        = string
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel"
  default     = null
}

variable "vpn_connection_tunnel2_phase1_encryption_algorithms" {
  type        = list(string)
  description = <<-EOT
    List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations.
    Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_phase2_encryption_algorithms" {
  type        = list(string)
  description = <<-EOT
    List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations.
    Valid values are AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_phase1_integrity_algorithms" {
  type        = list(string)
  description = <<-EOT
    One or more integrity algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations.
    Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_phase2_integrity_algorithms" {
  type        = list(string)
  description = <<-EOT
    One or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations.
    Valid values are SHA1 | SHA2-256 | SHA2-384 | SHA2-512
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_phase1_dh_group_numbers" {
  type        = list(string)
  description = <<-EOT
    List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations.
    Valid values are 2 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_phase2_dh_group_numbers" {
  type        = list(string)
  description = <<-EOT
    List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations.
    Valid values are 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_phase1_lifetime_seconds" {
  type        = string
  description = "The lifetime for phase 1 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 28800"
  default     = "28800"
  nullable    = false
}

variable "vpn_connection_tunnel2_phase2_lifetime_seconds" {
  type        = string
  description = "The lifetime for phase 2 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 3600"
  default     = "3600"
  nullable    = false
}

variable "vpn_connection_tunnel2_preshared_key" {
  type        = string
  description = "The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_)"
  default     = null
}

variable "vpn_connection_tunnel2_startup_action" {
  type        = string
  description = "The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are `add` | `start`"
  default     = "add"
  nullable    = false
}

variable "vpn_connection_tunnel2_cloudwatch_log_enabled" {
  type        = bool
  description = "Enable or disable VPN tunnel logging feature for the tunnel"
  default     = false
  nullable    = false
}

variable "vpn_connection_tunnel2_cloudwatch_log_group_arn" {
  type        = list(string)
  description = <<-EOT
    The ARN of the CloudWatch log group to which the logs will be published.
    If the list is empty and `vpn_connection_tunnel2_cloudwatch_log_enabled` is `true`,
    the module will create a new log group and use it.
    If the list is not empty, the module will use the first ARN in the list.
    EOT
  default     = []
  nullable    = false
}

variable "vpn_connection_tunnel2_cloudwatch_log_output_format" {
  type        = string
  description = "Set log format for the tunnel. Default format is json. Possible values are `json` and `text`"
  default     = "json"
  nullable    = false
}

variable "existing_transit_gateway_id" {
  type        = string
  default     = ""
  description = <<-EOT
    Existing Transit Gateway ID. Required if `transit_gateway_enabled` is `true`, ignored otherwise.
    To set up a transit gateway, one can use the`cloudposse/transit-gateway/aws` module and pass
    the output `transit_gateway_id` to this variable.
    EOT
}

variable "transit_gateway_enabled" {
  type        = bool
  description = <<-EOT
    If `true`, the module will not create a Virtual Private Gateway but instead will attach
    the VPN connection to the Transit Gateway specified by `existing_transit_gateway_id`
    EOT
  default     = false
  nullable    = false
}

variable "transit_gateway_route_table_id" {
  type        = string
  description = "The ID of the route table for the transit gateway that you want to associate + propagate the VPN connection's TGW attachment"
  default     = null
}

variable "transit_gateway_routes" {
  type = map(object({
    blackhole              = optional(bool, false)
    destination_cidr_block = string
  }))
  description = "A map of transit gateway routes to create on the given TGW route table (via `transit_gateway_route_table_id`) for the created VPN Attachment. Use the key in the map to describe the route"
  default     = {}
  nullable    = false
}

variable "vpn_acceleration_enabled" {
  type        = bool
  description = <<-EOT
    Set to true to enable VPN acceleration for the VPN connection. Can only be set at creation time, cannot be changed later.
    Accelerated VPN connections come with several restrictions: consult the AWS documentation for details.
    EOT
  default     = false
  nullable    = false
}
