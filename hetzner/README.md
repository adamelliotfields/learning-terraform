# Learning Terraform: Hetzner

This example will create the following resources on Hetzner Cloud:
  * RSA public key
  * Private network
  * Private network subnet
  * Server

The server is provisioned using a `cloud-config.yml` configuration that is rendered using the
`templatefile()` function.

## Input Variables

Put these in `terraform.tfvars` in the `hetzner` subfolder.

```hcl
# SSH user name
user = "adam"

# Number of servers to create
server_count = 1

# Hetzner API token
hcloud_token = ""

# RSA public key for SSH
rsa_public = ""

# RSA private key for SSH
rsa_private = <<EOF

EOF
```
