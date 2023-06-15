#! /bin/bash
hostIP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

sudo apt update -y 

mkdir ~/.kube && curl -sfL https://get.k3s.io | "INSTALL_K3S_EXEC=\"--write-kubeconfig=/home/ubuntu/.kube/k3s_kubeconfig.yaml --write-kubeconfig-mode=644 --node-external-ip=$hostIP\" sh -"

echo "K3s successfully installed..."
