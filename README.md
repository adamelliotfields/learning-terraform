# Learning Terraform

> :earth_americas: Learning Terraform by example(s).

In order to better understand Terraform, I wanted to create a couple examples.

Although the name of the repository sounds like a book or course, it's really just a bunch of stuff
I wrote when I was _learning Terraform_.

## Introduction

I started with using the Docker provider and then added the MySQL provider. This was a nice starting
point because I didn't need to actually provision any cloud resources that incur a cost.

Once I was comfortable with the syntax, folder structure, and how modules and dependencies work, I
moved on to actually provisioning resources on Hetzner. I chose Hetzner because their prices are so
low, plus they have a great REST API, CLI, and a well-documented Terraform provider.

## Installation

```bash
# macOS
brew install terraform

# Windows
scoop install terraform
```

## Usage

```bash
# Deploy the Docker example
terraform apply -auto-approve docker

# Deploy the Hetzner example
terraform apply -auto-approve hetzner
```

## IDE

The Terraform plugin from Jetbrains for their family of IDEs works the best out of the box.

There is an unofficial VS Code extension, but it doesn't appear to work with Terraform `0.12`. Note
that the Microsoft Terraform extension is only used for provisioning Azure resources.

## Examples

  - [Docker](./docker)
  - [Hetzner](./hetzner)

## Notes

### Folder Structure

I'm attempting to follow the recommended [folder structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

Personally, I think it would make more sense to use filenames that describe their contents, like
`data.tf` and `resources.tf`.

```
.
├── foo
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── bar
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── main.tf
└── terraform.tfvars
```

## References

  - https://gist.github.com/brianshumate/09adf967c563731ca1b0c4d39f7bcdc2
  - https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d
  - https://coderbook.com/@marcus/how-to-split-and-organize-terraform-code-into-modules
