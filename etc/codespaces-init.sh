#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. ${SCRIPT_DIR}/.env
. ${SCRIPT_DIR}/build-vars.sh
. ${SCRIPT_DIR}/utility.sh
 
checkOpenShiftClient
checkOperatorSDK
ocadmin
