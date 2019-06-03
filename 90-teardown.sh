#!/bin/bash

multipass copy-files ./voldown.sh microk8s-vm:./; 
multipass exec microk8s-vm sudo chmod 777 voldown.sh; 
multipass exec microk8s-vm sudo ./voldown.sh;

# kubectl exec -i -n kube-system calicoctl -- /calicoctl delete -f - < 80-policy.yaml
# kubectl delete -f 70-yaobank.yaml
# kubectl delete -f 50-spire-agent.yaml
# kubectl delete -f 40-authorization.yaml
# kubectl delete -f 30-spire-server.yaml