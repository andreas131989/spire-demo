#!/bin/bash

set -e

multipass copy-files ./volup.sh microk8s-vm:./; 
multipass exec microk8s-vm sudo chmod 777 volup.sh; 
multipass exec microk8s-vm sudo ./volup.sh; 

echo
echo "=== Installing Calico ==="
echo
kustomize build ./bases/calico | kubectl --kubeconfig=kubeconfig apply -f -
for x in $(seq 1000); do
  if kubectl --kubeconfig=kubeconfig get pod -n kube-system -l k8s-app=calico-node | grep -q 1/1; then
    break
  fi
  sleep 0.2
done

echo
echo "=== Installing SPIRE ==="
echo
kustomize build ./bases/spire | kubectl --kubeconfig=kubeconfig apply -f -
for x in $(seq 10000); do
  if kubectl --kubeconfig=kubeconfig get statefulset -n spire spire-server | grep -q 1/1; then
    break
  fi
  sleep 0.2
done
for x in $(seq 10000); do
  if kubectl --kubeconfig=kubeconfig get pod -n spire -l app=spire-agent | grep -q 1/1; then
    break
  fi
  sleep 0.2
done

echo
echo "=== Creating identities ==="
echo
sleep 15
./bases/spire/60-create-entries.sh

echo
echo "=== Installing YAOBank/Envoy/Dikastes ==="
echo
kustomize build ./bases/bank | kubectl --kubeconfig=kubeconfig apply -f -
for x in $(seq 10000); do
  if kubectl --kubeconfig=kubeconfig get pod -n default -l app=database | grep -q 3/3; then
    break
  fi
  sleep 0.2
done
for x in $(seq 10000); do
  if kubectl --kubeconfig=kubeconfig get pod -n default -l app=summary | grep -q 3/3; then
    break
  fi
  sleep 0.2
done
for x in $(seq 10000); do
  if kubectl --kubeconfig=kubeconfig get pod -n default -l app=customer | grep -q 2/2; then
    break
  fi
  sleep 0.2
done


