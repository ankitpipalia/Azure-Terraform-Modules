# Azure Terraform Modules

Reusable Terraform modules for Microsoft Azure infrastructure.

## Why this repo matters
This repository is meant to be a reusable module catalog, not a collection of one-off stacks. The modules are organized by domain so platform teams can assemble higher-level environments with consistent naming, inputs, and outputs.

## Current repository utilities
- `Dockerfile` packages `tfsec` for static analysis runs against the repo.
- `cleanup.sh` removes common Terraform and Terragrunt local artifacts.
- `knowledge.md` captures repository rules, future improvements, and maintenance expectations.

## Module domains
- Compute
- Containers
- Databases
- Management
- Monitoring
- Networking
- Security
- Storage
- Web

## Expected usage pattern
1. Choose the module under `modules/<domain>/<module-name>`.
2. Review that module's variables and outputs.
3. Call the module from a stack repo or Terragrunt live configuration.
4. Run validation and security checks before promotion.

## Validation helpers
```bash
docker build -t azure-terraform-modules-tfsec .
docker run --rm azure-terraform-modules-tfsec
./cleanup.sh
```

## Notes
The root README intentionally stays high level. Module-specific details should live beside each module.
