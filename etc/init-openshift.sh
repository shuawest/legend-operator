#!/bin/bash

# Script init
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
. ${SCRIPT_DIR}/.env-ocp

if [ -f "/usr/local/bin/oc" ]; then
    echo "openshift oc client installed."
else
    echo "installing openshift oc client..."
    oc_client_install
fi

echo "logging into openshift as admin"
ocpadmin
