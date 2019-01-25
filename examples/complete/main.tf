provider "aws" {
  region = "${var.region}"
}

module "vpn_connection" {
  source                                    = "../../"
  enabled                                   = "${var.enabled}"
  namespace                                 = "${var.namespace}"
  stage                                     = "${var.stage}"
  name                                      = "${var.name}"
  delimiter                                 = "${var.delimiter}"
  attributes                                = "${var.attributes}"
  tags                                      = "${var.tags}"
  vpc_id                                    = "${var.vpc_id}"
  vpn_gateway_amazon_side_asn               = "${var.vpn_gateway_amazon_side_asn}"
  customer_gateway_bgp_asn                  = "${var.customer_gateway_bgp_asn}"
  customer_gateway_ip_address               = "${var.customer_gateway_ip_address}"
  route_table_ids                           = ["${var.route_table_ids}"]
  vpn_connection_static_routes_only         = "${var.vpn_connection_static_routes_only}"
  vpn_connection_static_routes_destinations = "${var.vpn_connection_static_routes_destinations}"
  vpn_connection_tunnel1_inside_cidr        = "${var.vpn_connection_tunnel1_inside_cidr}"
  vpn_connection_tunnel2_inside_cidr        = "${var.vpn_connection_tunnel2_inside_cidr}"
  vpn_connection_tunnel1_preshared_key      = "${var.vpn_connection_tunnel1_preshared_key}"
  vpn_connection_tunnel2_preshared_key      = "${var.vpn_connection_tunnel2_preshared_key}"
}
