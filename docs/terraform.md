<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_vpn_connection.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection_route.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection_route) | resource |
| [aws_vpn_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [aws_vpn_gateway_route_propagation.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_route_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_customer_gateway_bgp_asn"></a> [customer\_gateway\_bgp\_asn](#input\_customer\_gateway\_bgp\_asn) | The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN) | `number` | `65000` | no |
| <a name="input_customer_gateway_ip_address"></a> [customer\_gateway\_ip\_address](#input\_customer\_gateway\_ip\_address) | The IP address of the gateway's Internet-routable external interface | `string` | n/a | yes |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated | `list(string)` | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to which the Virtual Private Gateway will be attached | `string` | n/a | yes |
| <a name="input_vpn_connection_local_ipv4_network_cidr"></a> [vpn\_connection\_local\_ipv4\_network\_cidr](#input\_vpn\_connection\_local\_ipv4\_network\_cidr) | The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpn_connection_remote_ipv4_network_cidr"></a> [vpn\_connection\_remote\_ipv4\_network\_cidr](#input\_vpn\_connection\_remote\_ipv4\_network\_cidr) | The IPv4 CIDR on the AWS side of the VPN connection. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpn_connection_static_routes_destinations"></a> [vpn\_connection\_static\_routes\_destinations](#input\_vpn\_connection\_static\_routes\_destinations) | List of CIDR blocks to be used as destination for static routes. Routes to destinations will be propagated to the route tables defined in `route_table_ids` | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_static_routes_only"></a> [vpn\_connection\_static\_routes\_only](#input\_vpn\_connection\_static\_routes\_only) | If set to `true`, the VPN connection will use static routes exclusively. Static routes must be used for devices that don't support BGP | `string` | `"true"` | no |
| <a name="input_vpn_connection_tunnel1_dpd_timeout_action"></a> [vpn\_connection\_tunnel1\_dpd\_timeout\_action](#input\_vpn\_connection\_tunnel1\_dpd\_timeout\_action) | The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"clear"` | no |
| <a name="input_vpn_connection_tunnel1_ike_versions"></a> [vpn\_connection\_tunnel1\_ike\_versions](#input\_vpn\_connection\_tunnel1\_ike\_versions) | The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_inside_cidr"></a> [vpn\_connection\_tunnel1\_inside\_cidr](#input\_vpn\_connection\_tunnel1\_inside\_cidr) | The CIDR block of the inside IP addresses for the first VPN tunnel | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_phase1_dh_group_numbers"></a> [vpn\_connection\_tunnel1\_phase1\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel1\_phase1\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase1_encryption_algorithms"></a> [vpn\_connection\_tunnel1\_phase1\_encryption\_algorithms](#input\_vpn\_connection\_tunnel1\_phase1\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase1_integrity_algorithms"></a> [vpn\_connection\_tunnel1\_phase1\_integrity\_algorithms](#input\_vpn\_connection\_tunnel1\_phase1\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase2_dh_group_numbers"></a> [vpn\_connection\_tunnel1\_phase2\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel1\_phase2\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase2_encryption_algorithms"></a> [vpn\_connection\_tunnel1\_phase2\_encryption\_algorithms](#input\_vpn\_connection\_tunnel1\_phase2\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_phase2_integrity_algorithms"></a> [vpn\_connection\_tunnel1\_phase2\_integrity\_algorithms](#input\_vpn\_connection\_tunnel1\_phase2\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel1_preshared_key"></a> [vpn\_connection\_tunnel1\_preshared\_key](#input\_vpn\_connection\_tunnel1\_preshared\_key) | The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(\_) | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_startup_action"></a> [vpn\_connection\_tunnel1\_startup\_action](#input\_vpn\_connection\_tunnel1\_startup\_action) | The action to take when the establishing the tunnel for the first VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start. | `string` | `"add"` | no |
| <a name="input_vpn_connection_tunnel2_dpd_timeout_action"></a> [vpn\_connection\_tunnel2\_dpd\_timeout\_action](#input\_vpn\_connection\_tunnel2\_dpd\_timeout\_action) | The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"clear"` | no |
| <a name="input_vpn_connection_tunnel2_ike_versions"></a> [vpn\_connection\_tunnel2\_ike\_versions](#input\_vpn\_connection\_tunnel2\_ike\_versions) | The IKE versions that are permitted for the second VPN tunnel. Valid values are ikev1 \| ikev2. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_inside_cidr"></a> [vpn\_connection\_tunnel2\_inside\_cidr](#input\_vpn\_connection\_tunnel2\_inside\_cidr) | The CIDR block of the inside IP addresses for the second VPN tunnel | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_phase1_dh_group_numbers"></a> [vpn\_connection\_tunnel2\_phase1\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel2\_phase1\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase1_encryption_algorithms"></a> [vpn\_connection\_tunnel2\_phase1\_encryption\_algorithms](#input\_vpn\_connection\_tunnel2\_phase1\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase1_integrity_algorithms"></a> [vpn\_connection\_tunnel2\_phase1\_integrity\_algorithms](#input\_vpn\_connection\_tunnel2\_phase1\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase2_dh_group_numbers"></a> [vpn\_connection\_tunnel2\_phase2\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel2\_phase2\_dh\_group\_numbers) | List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase2_encryption_algorithms"></a> [vpn\_connection\_tunnel2\_phase2\_encryption\_algorithms](#input\_vpn\_connection\_tunnel2\_phase2\_encryption\_algorithms) | List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_phase2_integrity_algorithms"></a> [vpn\_connection\_tunnel2\_phase2\_integrity\_algorithms](#input\_vpn\_connection\_tunnel2\_phase2\_integrity\_algorithms) | One or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | `[]` | no |
| <a name="input_vpn_connection_tunnel2_preshared_key"></a> [vpn\_connection\_tunnel2\_preshared\_key](#input\_vpn\_connection\_tunnel2\_preshared\_key) | The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero. Allowed characters are alphanumeric characters, periods(.) and underscores(\_) | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_startup_action"></a> [vpn\_connection\_tunnel2\_startup\_action](#input\_vpn\_connection\_tunnel2\_startup\_action) | The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start. | `string` | `"add"` | no |
| <a name="input_vpn_gateway_amazon_side_asn"></a> [vpn\_gateway\_amazon\_side\_asn](#input\_vpn\_gateway\_amazon\_side\_asn) | The Autonomous System Number (ASN) for the Amazon side of the VPN gateway. If you don't specify an ASN, the Virtual Private Gateway is created with the default ASN | `number` | `64512` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_gateway_id"></a> [customer\_gateway\_id](#output\_customer\_gateway\_id) | Customer Gateway ID |
| <a name="output_vpn_connection_customer_gateway_configuration"></a> [vpn\_connection\_customer\_gateway\_configuration](#output\_vpn\_connection\_customer\_gateway\_configuration) | The configuration information for the VPN connection's Customer Gateway (in the native XML format) |
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | VPN Connection ID |
| <a name="output_vpn_connection_tunnel1_address"></a> [vpn\_connection\_tunnel1\_address](#output\_vpn\_connection\_tunnel1\_address) | The public IP address of the first VPN tunnel |
| <a name="output_vpn_connection_tunnel1_cgw_inside_address"></a> [vpn\_connection\_tunnel1\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_cgw\_inside\_address) | The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway side) |
| <a name="output_vpn_connection_tunnel1_vgw_inside_address"></a> [vpn\_connection\_tunnel1\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel1\_vgw\_inside\_address) | The RFC 6890 link-local address of the first VPN tunnel (Virtual Private Gateway side) |
| <a name="output_vpn_connection_tunnel2_address"></a> [vpn\_connection\_tunnel2\_address](#output\_vpn\_connection\_tunnel2\_address) | The public IP address of the second VPN tunnel |
| <a name="output_vpn_connection_tunnel2_cgw_inside_address"></a> [vpn\_connection\_tunnel2\_cgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_cgw\_inside\_address) | The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway side) |
| <a name="output_vpn_connection_tunnel2_vgw_inside_address"></a> [vpn\_connection\_tunnel2\_vgw\_inside\_address](#output\_vpn\_connection\_tunnel2\_vgw\_inside\_address) | The RFC 6890 link-local address of the second VPN tunnel (Virtual Private Gateway side) |
| <a name="output_vpn_gateway_id"></a> [vpn\_gateway\_id](#output\_vpn\_gateway\_id) | Virtual Private Gateway ID |
<!-- markdownlint-restore -->
