# Azure Terraform Modules

## Commands
- `docker build -t azure-terraform-modules-tfsec .`
- `./cleanup.sh`

## Architecture
- This repository is a catalog of reusable Azure Terraform modules grouped by domain.
- Prefer module-level documentation, typed variables, safe defaults, and composable outputs.

## Rules
- Do not commit `terraform.tfvars`, state files, or provider credentials.
- Keep README category listings aligned with actual module paths.
- Document breaking input/output changes in pull requests and module READMEs.
