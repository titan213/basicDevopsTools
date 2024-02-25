#!/bin/bash

# Source aliases
if [ -f "/usr/src/app/set-aliases.sh" ]; then
    source /usr/src/app/set-aliases.sh
fi

echo "*************************************************"
echo "*                  DEVOPS TOOLS IMAGE           *"
echo "*                  Maintainer: titan213         *"
echo "*                                               *"
echo "*                                               *"
echo "*                                               *"
echo "*************************************************"


# Function to print versions in a formatted manner
print_versions() {
    echo "Installed Software Versions:"
    echo "----------------------------"
    printf "%-15s: %s\n" "Git" "$(git --version | awk '{print $3}')"
    printf "%-15s: %s\n" "Python" "$(python --version 2>&1)"
    printf "%-15s: %s\n" "Azure CLI" "$(az --version | grep azure-cli | awk '{print $2}')"
    printf "%-15s: %s\n" "AWS CLI" "$(aws --version 2>&1 | awk '{print $1}')"
    printf "%-15s: %s\n" "Terraform" "$(terraform version | head -n1)"
    printf "%-15s: %s\n" "Ansible" "$(ansible --version | head -n1 | awk '{print $2}')"
    printf "%-15s: %s\n" "kubectl" "$(kubectl version --client --short | awk '{print $3}')"
    echo "----------------------------"
}

# Print software versions
print_versions

# Keep the container running
echo "Container started..."
tail -f /dev/null
