resource "hcloud_network" "ens10" {
  name = "ens10"
  ip_range = "192.168.0.0/16"
}

# On Debian-based distributions, the first private network is `ens10`.
# Currently the only type is `server` and the only zone is `eu-central`.
resource "hcloud_network_subnet" "ens10" {
  type = "server"
  network_zone = "eu-central"
  ip_range = "192.168.0.0/24"
  network_id = hcloud_network.ens10.id
}
