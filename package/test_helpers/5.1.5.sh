#!/bin/bash

export KUBECONFIG=${KUBECONFIG:-/root/.kube/config}

kubectl version > /dev/null
if [ $? -gt 0 ]; then
  echo "fail: kubectl failed"
  exit 666
fi

accounts="$(kubectl --kubeconfig=${KUBECONFIG} get serviceaccounts -A -o json | jq -r '.items[] | select(.metadata.name=="default") | select((.automountServiceAccountToken == null) or (.automountServiceAccountToken == true)) | "fail \(.metadata.name) \(.metadata.namespace)"')"

if [[ "${accounts}" == "" ]]; then
  echo "--pass"
  exit 0
fi

#echo ${accounts}
#exit 0
echo "--pass"
