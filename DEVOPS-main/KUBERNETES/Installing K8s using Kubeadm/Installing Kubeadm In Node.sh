# ------------------------
# ------------------------
# INSTALLING KUBEADM IN NODE [UBUNTU 20.04]
# ------------------------
# ------------------------
# Reference: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#k8s-install-0

# Updating the OS
sudo apt-get update -y
# apt-transport-https may be a dummy package; if so, you can skip that package

# ------------------------
# INSTALL DOCKER
# ------------------------
sudo apt update -y                #(update the OS)
sudo apt install docker.io -y     #(install docker)
sudo service docker start    	  #(start docker service)

# ------------------------
# INSTALL KUBECTL
# ------------------------

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

sudo apt-mark hold kubelet kubeadm kubectl

# ------------------------
# Check Kubernetes version
# ------------------------
kubectl version


# =============================

# Run these commands separately
sudo su -
# <paste the token from Master>

systemctl restart kubelet
