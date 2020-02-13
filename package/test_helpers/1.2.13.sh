#!/bin/bash

ps -ef|grep kube-apiserver|grep -enable-admission-plugins|grep PodSecurityPolicy
if [ $? -eq 0 ]; then
  echo "pass"
else
  echo "fail: PodSecurityPolicy plugin not enabled"
  exit 666
fi
