# Use an official Python runtime 3.12.2
FROM python:3.12.2-slim-bullseye

LABEL maintainer="titan213"
LABEL image="DevopsTools"

# Set the working directory in the container
WORKDIR /data

# Arguments for software versions
ARG TERRAFORM_VERSION
ARG KUBECTL_VERSION

# Install basic utilities and required tools
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
                git \
                curl \
                unzip \
                software-properties-common \
                lsb-release \
                tar \
                nano \
                openssh-client \
                sshpass && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    curl -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    chmod 0755 terraform && \
    mv terraform /usr/local/bin && \
    pip3 install --no-cache-dir ansible && \
    curl -s -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* awscliv2.zip terraform.zip

# Copy scripts to workdir
COPY scripts /usr/src/app/scripts

# Set up a volume for external data
VOLUME /data

# Expose port 80 
EXPOSE 80

RUN chmod +x /usr/src/app/scripts/set-alias.sh /usr/src/app/scripts/entrypoint.sh

ENV ANSIBLE_GATHERING=smart \
    ANSIBLE_HOST_KEY_CHECKING=false \
    ANSIBLE_RETRY_FILES_ENABLED=false \
    ANSIBLE_SSH_PIPELINING=True \
    EDITOR=nano

# Setup ENTRYPOINT
ENTRYPOINT ["/usr/src/app/scripts/entrypoint.sh"]
