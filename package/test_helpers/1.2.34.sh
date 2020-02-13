#!/bin/bash -e

check_file=${1}

grep -q -E 'aescbc|kms|secretbox' ${check_file}
if [ $? -eq 0 ]; then
  echo "--pass"
  exit 0
else
  echo "fail: encryption provider found in ${check_file}"
  exit 1
fi
