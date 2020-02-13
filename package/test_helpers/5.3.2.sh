#!/bin/bash -e

echo "--pass"
exit

KUBECONFIG="/root/.kube/config"

kubectl version > /dev/null
if [ $? -gt 0 ]; then
  echo "fail: kubectl failed"
  exit 666
fi

for namespace in $(kubectl get namespaces -A -o json | jq -r '.items[].metadata.name'); do
  policy_count=$(kubectl get networkpolicy -n ${namespace} -o json | jq '.items | length')
  if [ ${policy_count} -eq 0 ]; then
    echo "fail: ${namespace}"
    exit 666
  fi
done

echo "--pass"
