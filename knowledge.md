# Azure Terraform Modules Knowledge

## Purpose
Reusable Terraform modules for common Azure infrastructure patterns across compute, networking, storage, monitoring, databases, security, and web workloads.

## Current repo shape
- Module catalog grouped by domain under `modules/`
- Repo-level tfsec container for quick static checks
- Cleanup helper for Terragrunt/Terraform local artifacts

## Working rules
- Treat each module as a reusable contract, not a one-off stack.
- Keep variable names predictable and outputs minimal but useful.
- Keep the root README aligned with real module paths.
- Never commit provider secrets, state, or local tfvars.

## Future improvements
- Add per-module example stacks for high-value modules.
- Add CI for `terraform fmt -check`, `terraform validate`, and `tfsec`.
- Add ownership and maturity markers to the module catalog.
