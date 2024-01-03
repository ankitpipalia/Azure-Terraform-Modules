#!/bin/bash

# Define an array of filenames and directory names to search and delete
declare -a items_to_delete=(
  ".terragrunt-cache"
  ".terraform.lock.hcl"
  ".terraform.tfstate.lock.info"
  "terraform.tfstate"
  "terraform.tfstate.backup"
  ".terraform"
  ".infracost"
  ".terraform-modules"
  "terraform.tfvars"
  "terragrunt-debug.tfvars.json"
)

# Function to remove files and directories
remove_items() {
  local item=$1
  # Find all instances in subdirectories and remove them
  find . -name "$item" -exec rm -rf {} +
}

# Loop over items and remove them
for item in "${items_to_delete[@]}"; do
  echo "Removing $item..."
  remove_items "$item"
done

echo "Cleanup complete."