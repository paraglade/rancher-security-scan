#!/bin/bash -e

api_server_bin=${1}

/bin/ps -ef | /bin/grep ${api_server_bin} | /bin/grep -v ${0} | /bin/grep -v grep
