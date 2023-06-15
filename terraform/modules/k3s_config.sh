#! /bin/bash

publicDNS=$1
publicIP=$2
configPath=~/.kube/aws_k3s_config.yaml

if [ -f $configPath ]; then
    rm -rf $configPath
fi

scp -o StrictHostKeyChecking=no -i ~/.ssh/aws_wsl.pem ubuntu@"$publicDNS":/home/ubuntu/.kube/k3s_kubeconfig.yaml $configPath

sed -i "s/127.0.0.1/$publicIP/g" $configPath
