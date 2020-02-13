#!/bin/bash -e

export KUBECONFIG=${KUBECONFIG:-/root/.kube/config}

kubectl version > /dev/null
if [[ $? -gt 0 ]]; then
  echo "fail: kubectl failed"
  exit 666
fi

default_resources=$(kubectl get all -o json | jq --compact-output '.items[] | select((.kind == "Service") and (.metadata.name == "kubernetes") and (.metadata.namespace == "default") | not)' | wc -l)

echo "--count=${default_resources}"
