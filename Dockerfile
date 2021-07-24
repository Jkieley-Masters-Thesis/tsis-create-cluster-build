FROM ubuntu:18.04

WORKDIR /app

RUN apt-get update && \
apt-get install -y curl && \
apt-get install -y unzip && \
apt-get install -y sudo && \
apt-get install -y openssh-client && \
apt-get install -y groff && \
apt-get install -y less && \
apt-get install -y jq

# install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
sudo ./aws/install

# install helm
# https://helm.sh/docs/intro/install/
RUN curl -Lo helm-v3.3.1-linux-amd64.tar.gz https://get.helm.sh/helm-v3.3.1-linux-amd64.tar.gz && \
tar -zxvf helm-v3.3.1-linux-amd64.tar.gz && \
chmod +x ./linux-amd64/helm && \
mv ./linux-amd64/helm /usr/local/bin/helm

# install kops cli
RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/v1.18.2/kops-linux-amd64 && \
chmod +x kops && \
mv kops /usr/local/bin/kops

# install kubectl
RUN sudo apt-get install -y apt-transport-https gnupg2 curl && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
sudo apt-get update && \
sudo apt-get install -y kubectl

ADD ./create_cluster.sh /app/create_cluster.sh
ADD ./init-cluster /app/init-cluster
ADD ./promethius-grafana /app/promethius-grafana
ADD ./entrypoint.sh /app/entrypoint.sh
ADD ./delete_cluster.sh /app/delete_cluster.sh
ADD ./delete_cluster.sh /app/delete_cluster.sh
ADD ./promethius-grafana/promethius-values.yaml /app/promethius-values.yaml
ADD ./promethius-grafana/grafana-values.yaml /app/grafana-values.yaml

RUN mkdir mount && \
mkdir -p /root/.ssh && \
sudo touch /root/.ssh/known_hosts

ENTRYPOINT bash ./entrypoint.sh