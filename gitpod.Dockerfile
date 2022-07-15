ARG GITPOD_IMAGE=gitpod/workspace-full:latest
FROM ${GITPOD_IMAGE}

USER root

# Install tailscale Helm and Kubectl
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
     apt-get install -y helm kubectl &&\
     echo "Helm version: " && helm version &&\
     echo "kubectl version: " && kubectl version --client


# Install SDKMan, Spark and Flink
RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh &&\
     sdk install java 11.0.14-zulu &&\
     sdk install spark 3.1.2 &&\
     sdk install flink 1.14.0 &&\
     sdk install kcctl &&\
     sdk install scala &&\
     sdk install visualvm" &&\
     apt-get install -y mysql-client &&\
     pip3 install jupyterlab pandas matplotlib pyspark==3.1.2 &&\
     # Cleaning up
     rm -rf /var/lib/apt



