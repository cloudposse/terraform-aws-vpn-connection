## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (e.g. `1`) | list | `<list>` | no |
| customer_gateway_bgp_asn | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN) | string | `65000` | no |
| customer_gateway_ip_address | The IP address of the gateway's Internet-routable external interface | string | - | yes |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| enabled | Set to `false` to prevent the module from creating any resources | string | `true` | no |
| name | Name  (e.g. `app`) | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | - | yes |
| route_table_ids | The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated | list | `<list>` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Additional tags (e.g. `{ BusinessUnit = "XYZ" }` | map | `<map>` | no |
| vpc_id | The ID of the VPC to which the Virtual Private Gateway will be attached | string | - | yes |
| vpn_connection_static_routes_destinations | List of CIDR blocks to be used as destination for static routes. Routes to destinations will be propagated to the route tables defined in `route_table_ids` | list | `<list>` | no |
| vpn_connection_static_routes_only | If set to `true`, the VPN connection will use static routes exclusively. Static routes must be used for devices that don't support BGP | string | `true` | no |
| vpn_connection_tunnel1_inside_cidr | The CIDR block of the inside IP addresses for the first VPN tunnel | string | `` | no |
| vpn_connection_tunnel1_preshared_key | The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_) | string | `` | no |
| vpn_connection_tunnel2_inside_cidr | The CIDR block of the inside IP addresses for the second VPN tunnel | string | `` | no |
| vpn_connection_tunnel2_preshared_key | The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(_) | string | `` | no |
| vpn_gateway_amazon_side_asn | The Autonomous System Number (ASN) for the Amazon side of the VPN gateway. If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN | string | `64512` | no |

## Outputs

| Name | Description |
|------|-------------|
| customer_gateway_id | Customer Gateway ID |
| vpn_connection_customer_gateway_configuration | The configuration information for the VPN connection's Customer Gateway (in the native XML format) |
| vpn_connection_id | VPN Connection ID |
| vpn_connection_tunnel1_address | The public IP address of the first VPN tunnel |
| vpn_connection_tunnel1_cgw_inside_address | The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway side) |
| vpn_connection_tunnel1_vgw_inside_address | The RFC 6890 link-local address of the first VPN tunnel (Virtual Private Gateway side) |
| vpn_connection_tunnel2_address | The public IP address of the second VPN tunnel |
| vpn_connection_tunnel2_cgw_inside_address | The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway side) |
| vpn_connection_tunnel2_vgw_inside_address | The RFC 6890 link-local address of the second VPN tunnel (Virtual Private Gateway side) |
| vpn_gateway_id | Virtual Private Gateway ID |

