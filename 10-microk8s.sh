#!/bin/bash -x

multipass copy-files ./volup.sh microk8s-vm:./; 
multipass exec microk8s-vm sudo chmod 777 volup.sh; 
multipass exec microk8s-vm sudo ./volup.sh; 