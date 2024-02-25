# Use an official Python runtime 3.12.2
FROM python:3.12.2-slim-bullseye

LABEL mainteiner="titan213"
LABEL image="DevopsTools"

# Set the working directory in the container
WORKDIR /usr/src/app

#Arguments for software versions
ARG ANSIBLE_VERSION
ARG TERRAFORM_VERSION
ARG KUBECTL_VERSION

# Install basic utilities
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y --no-install-recommends git curl unzip software-properties-common lsb-release gnupg gcc

#copy scripts to workdir
COPY set-alias.sh entrypoint.sh /usr/src/app/

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Install Terraform 
RUN curl -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && chmod 0755 terraform \
    && mv terraform /usr/local/bin

# Install Ansible 
RUN pip3 install --upgrade pip;\
    pip3 install "ansible==${ANSIBLE_VERSION}"; \
    pip3 install ansible


# Install kubectl 
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* awscliv2.zip

# Verify installations
RUN git --version && \
    python --version && \
    az --version && \
    aws --version && \
    terraform --version && \
    ansible --version && \
    kubectl version --client

# Set up a volume for external data
VOLUME /data

# expose port 80 
EXPOSE 80

RUN chmod +x /usr/src/app/set-alias.sh /usr/src/app/entrypoint.sh

# Setup ENTRYPOINT
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# Run shell on container start
CMD [ "/bin/bash" ]
