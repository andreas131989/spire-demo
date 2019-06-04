#!/bin/bash

set -e

echo
echo "=== Installing Calico policy ==="
echo
kubectl --kubeconfig=kubeconfig exec -i -n kube-system calicoctl -- /calicoctl apply -f - < policy.yaml


