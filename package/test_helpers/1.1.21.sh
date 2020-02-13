#!/bin/bash -e
check_dir=${1:-/etc/kubernetes/ssl}

for file in $(find ${check_dir} -name "*key.pem"); do
	file_permission=$(stat -c %a ${file})
  if [[ "${file_permission}" == "600" ]]; then
    continue
  else
    echo "FAIL: ${file} ${file_permission}"
    exit 666
  fi
done

echo "pass"
