#!/bin/bash -e

check_files=${1}

for file in $(find ${check_files} -maxdepth 1 -type f ); do
	file_permission=$(stat -c %a ${file})
  if [[ "${file_permission}" = "644" ]]; then
    continue
	elif [[ "${file_permission}" = "640" ]]; then
    continue
  elif [[ "${file_permission}" = "600" ]]; then
    continue
  else
    echo "FAIL: ${file} ${file_permission}"
    exit
  fi
done

echo "pass"
