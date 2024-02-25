param (
    [string]$TerraformVersion = "1.6.0",
    [string]$AnsibleVersion = "2.12.0",
    [string]$KubectlVersion = "1.27.2"
)

# Define the Docker image name
$imageName = "devopstools"

# Build the Docker image with version arguments
docker build `
    --build-arg TERRAFORM_VERSION=$TerraformVersion `
    --build-arg ANSIBLE_VERSION=$AnsibleVersion `
    --build-arg KUBECTL_VERSION=$KubectlVersion `
    -t $imageName .
