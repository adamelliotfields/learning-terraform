data "hcloud_datacenter" "nuremberg" {
  name = "nbg1-dc3"
}

data "hcloud_image" "debian" {
  name = "debian-10"
}

resource "hcloud_server" "demo" {
  count = var.server_count
  name = "demo-${count.index}"
  server_type = "cx11"
  image = data.hcloud_image.debian.name
  datacenter = data.hcloud_datacenter.nuremberg.name
  user_data = templatefile("${path.module}/../../templates/cloud-config.yml.tpl", {
    user: var.user
    rsa_public: var.rsa_public,
    rsa_private: var.rsa_private,
    docker_gpg: file("${path.module}/../../files/docker_gpg"),
    rules_v4: file("${path.module}/../../files/rules_v4"),
    rules_v6: file("${path.module}/../../files/rules_v6"),
    sshd_config: file("${path.module}/../../files/sshd_config")
  })
}

resource "hcloud_server_network" "ens10" {
  count = length(hcloud_server.demo)
  server_id = hcloud_server.demo[count.index].id
  network_id = var.network_id
  ip = "192.168.0.${count.index + 2}"
}
