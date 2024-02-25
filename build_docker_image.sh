#!/bin/bash

# Default software versions
TerraformVersion="1.6.0"
AnsibleVersion="2.12.0"
KubectlVersion="1.27.2"

# Parse command line arguments for versions
while [ "$1" != "" ]; do
    case $1 in
        -tf | --terraform )
            shift
            TerraformVersion=$1
            ;;
        -an | --ansible )
            shift
            AnsibleVersion=$1
            ;;
        -kc | --kubectl )
            shift
            KubectlVersion=$1
            ;;
        * )
            echo "Invalid argument: $1"
            exit 1
    esac
    shift
done

# Define the Docker image name
imageName="devopstools"

# Build the Docker image with version arguments
docker build \
    --build-arg TERRAFORM_VERSION=$TerraformVersion \
    --build-arg ANSIBLE_VERSION=$AnsibleVersion \
    --build-arg KUBECTL_VERSION=$KubectlVersion \
    -t $imageName .
