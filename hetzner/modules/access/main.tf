resource "hcloud_ssh_key" "rsa_public" {
  name = "rsa_public"
  public_key = var.rsa_public
}
