ARG GITPOD_IMAGE=gitpod/workspace-full-vnc:latest
# ARG GITPOD_IMAGE=gitpod/workspace-full:latest
FROM ${GITPOD_IMAGE}

USER root

RUN which brew && python -V && echo $SDKMAN_DIR 

# Install SDKMan, Spark and Flink
RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh &&\
     sdk install java 11.0.20-zulu &&\
     sdk install spark 3.4.0 &&\
     sdk install scala &&\
     sdk update"

RUN sudo install-packages postgresql-14 mysql-client

RUN pip3 -V && which pip

RUN pip3 install jupyterlab pandas matplotlib pyspark==3.4.0
RUN curl -sSL https://install.python-poetry.org | python3 -

# # Install tailscale Helm and Kubectl
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add - &&\
     curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list &&\
     sudo install-packages tailscale ca-certificates apt-transport-https
     