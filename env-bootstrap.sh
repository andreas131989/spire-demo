#!/bin/bash

set -e

echo
echo "=== Installing Homebrew ==="
echo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo
echo "=== Installing Multipass ==="
echo
brew search multipass
brew cask install multipass

echo
echo "=== Creating a microk8s vm with istio enabled ==="
echo
multipass launch --name microk8s-vm --mem 4G --disk 40G
multipass exec microk8s-vm -- sudo snap install microk8s --classic
multipass exec microk8s-vm -- sudo iptables -P FORWARD ACCEPT
#Need to wait for microk8s to be fully operational before enabling istio
sleep 60
multipass exec microk8s-vm -- sudo microk8s.enable istio

echo
echo "=== Fetch the kubeconfig for remote access ==="
echo
multipass exec microk8s-vm -- /snap/bin/microk8s.config > kubeconfig

