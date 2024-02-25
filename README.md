

# DevOps Tools Docker Image

## Overview
This Docker image is tailored for DevOps professionals, encapsulating a robust toolkit for managing and orchestrating cloud infrastructure. It packages git, Python, and a choice between Azure CLI or AWS CLI, along with Terraform, Ansible, and kubectl. This versatile image supports a wide range of DevOps tasks, from infrastructure provisioning to deployment automation across various cloud platforms.

## Included Tools
* git
* ansible
* Python
* terraform
* kubernetes client
* AWS CLI
* Azure CLI

## Prerequisites
- Docker must be installed on your machine. Visit [Docker's official website](https://www.docker.com/products/docker-desktop) for installation guides.
- Familiarity with Docker commands and concepts is recommended.

## Building the Image
To construct the image with the software's default versions, clone this repository and navigate to the directory containing the Dockerfile. 

### Linux:

```bash
chmod +x build_docker_image.sh
./build_docker_image.sh
```

### Windows/Powershell:
```powershell
.\buildDockerImage.ps1
```

## Customizing Software Versions
You can customize the versions of Terraform, Ansible, and kubectl by using build arguments. Here is an example command that specifies the versions:

```bash
   ./build_docker_image.sh --terraform "1.6.0" --ansible "2.12.0" --kubectl "1.27.2"
```

## Contributing
Please submit pull requests for any enhancements, bug fixes, or improvements you have made.

