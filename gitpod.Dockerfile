FROM gitpod/workspace-full

USER root

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add - &&\
     curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list &&\
     apt-get update &&\
     apt-get install -y tailscale ca-certificates apt-transport-https &&\
     # Install Kubectl and Helm
     curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg &&\
     echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list &&\
     # Update apt package index with the new repository and install kubectl
     # Add Helm key
     curl -sS https://baltocdn.com/helm/signing.asc | apt-key add - &&\
     echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list &&\
     # Update and Install Helm and Kubectl
     apt-get update &&\
     apt-get install helm kubectl &&\
     echo "Helm version: " && helm version &&\
     echo "kubectl version: " && kubectl version --client