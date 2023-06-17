#! /bin/bash
hostIP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

sudo apt update -y 

mkdir ~/.kube

if [ $? -eq 0 ]; then
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig=/home/ubuntu/.kube/aws_k3s_config --write-kubeconfig-mode=644 --node-external-ip=$hostIP" sh -

    echo "K3s successfully installed..."
fi
