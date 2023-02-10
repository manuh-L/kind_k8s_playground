#!/bin/bash

echo "##################################################################################
# Starting installation
##################################################################################"

cluster_name = "star-labs"
#Install docker
curl -fsSL https://get.docker.com/ | sh

#To install docker on Rocky OS comment the above line and uncomment the next line
#curl -fsSL https://releases.rancher.com/install-docker/20.10.sh | sh

#Enable & start docker
systemctl enable --now docker

#kubectl download
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv ./kubectl /usr/local/bin/kubectl

##################################################################################
# KIND
##################################################################################

#Download kind binary
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

#copy content to create the node cluster
#wget https://raw.githubusercontent.com/manuh-L/kind_k8s_playground/main/3node.yaml
curl -LO https://raw.githubusercontent.com/manuh-L/kind_k8s_playground/main/3node.yaml

#Create cluster
kind create cluster --name $cluster_name --config 3node.yaml 

#validate get cluster
kind get clusters
kubectl cluster-info --context kind-$cluster_name

echo "##################################################################################
# Done
##################################################################################"