#!/bin/bash

# Script init
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
. ${SCRIPT_DIR}/env.sh

# Initialize codespaces
${SCRIPT_DIR}/initialize-operators.sh
