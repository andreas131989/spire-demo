#!/bin/bash

set -e

echo
echo "=== Deleting policy ==="
echo
kubectl --kubeconfig=kubeconfig exec -i -n kube-system calicoctl -- /calicoctl delete -f - < policy.yaml

echo
echo "=== Deleting YAOBank/Envoy/Dikastes ==="
echo
kustomize build ./bases/bank | kubectl --kubeconfig=kubeconfig delete -f -

echo
echo "=== Deleting SPIRE ==="
echo
kustomize build ./bases/spire | kubectl --kubeconfig=kubeconfig delete -f -

echo
echo "=== Deleting Calico ==="
echo
kustomize build ./bases/calico | kubectl --kubeconfig=kubeconfig delete -f -

multipass copy-files ./voldown.sh microk8s-vm:./; 
multipass exec microk8s-vm sudo chmod 777 voldown.sh; 
multipass exec microk8s-vm sudo ./voldown.sh;