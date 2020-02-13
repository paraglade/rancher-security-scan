#!/bin/bash -e

KUBECONFIG=${KUBECONFIG:-/root/.kube/config}

kubectl version > /dev/null
if [ $? -eq 0 ]
  echo "fail: kubectl failed"
  exit 666
fi

count=$(kubectl --kubeconfig=/root/.kube/config get psp -o json | jq .items[] | jq -r 'select((.spec.hostPID == null) or (.spec.hostPID == false))' | jq .metadata.name | wc -l)

if [ ${count} -gt 0 ]; then
  echo "pass"
  exit
fi

echo "FAIL: count is ${count}"
exit 666
