#!/bin/bash

set -e

multipass delete microk8s-vm
multipass purge 
brew cask remove multipass
rm kubeconfig