#!/bin/sh -x
kubectl --kubeconfig=kubeconfig exec -i -n kube-system calicoctl -- /calicoctl apply -f - < 80-policy.yaml

