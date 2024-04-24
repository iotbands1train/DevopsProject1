# INSTALLING KUBEADM IN UBUNTU 20.04
# Reference: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#k8s-install-0

# Updating the OS
sudo apt-get update -y
# apt-transport-https may be a dummy package; if so, you can skip that package

# Installing Docker
sudo apt update -y                #(update the OS)
sudo apt install docker.io -y     #(install docker)
sudo service docker start    	  #(start docker service)
# Add ec2-user to the docker group so that Docker commands can be run w/o using sudo.
sudo usermod -aG docker $USER && newgrp docker  #(add normal user 'docker')
sudo chmod 777 /var/run/docker.sock

# Install package for Kubernetes apt repository
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# In older release less than Ubuntu 22.04 below directory must be created
sudo mkdir -m 755 /etc/apt/keyrings

# Download the public signing key for the Kubernetes package repositories
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the appropriate Kubernetes apt repository
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update the apt package index, install kubelet, kubeadm and kubectl
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl

#Check Kubernetes version
kubectl version

sudo apt-mark hold kubelet kubeadm kubectl


# --------

# Initialize Master or Control Plane
# Reference link: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#considerations-about-apiserver-advertise-address-and-controlplaneendpoint

sudo kubeadm init --pod-network-cidr=10.244.0.0/16  --ignore-preflight-errors=NumCPU --ignore-preflight-errors=Mem
# (Token will be generated for use in Node)

mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

kubectl get pods -A
kubectl get nodes -o wide


# Note:
# 1. CG group driver setup can be skipped for Docker
# 2. Install only the above commands in Node & then paste the token in the node by becoming root user
# 3. Now check the nodes in master, if the node is still showing 'NotReady' then run systemctl restart kubelet


