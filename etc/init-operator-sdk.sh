#!/bin/bash

# Reference documentation
# - Install Operator SDK: https://sdk.operatorframework.io/docs/installation/

# Set platform information
export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export SDK_PATH=/workspaces/operator-sdk

OPERATOR_SDK_VERSION=v1.26.0
OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}

OPERATOR_INSTALL="download" # "download|build"
GOPROXY="https://proxy.golang.org|direct"

# Setup operator sdk working directory
mkdir $SDK_PATH
pushd $SDK_PATH

# Install via download, or build from master
if [ $OPERATOR_INSTALL == "download" ]; then

    # Download operator-sdk binary
    curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}
    gpg --keyserver keyserver.ubuntu.com --recv-keys 052996E2A20B5C7E
    curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt
    curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt.asc
    gpg -u "Operator SDK (release) <cncf-operator-sdk@cncf.io>" --verify checksums.txt.asc
    grep operator-sdk_${OS}_${ARCH} checksums.txt | sha256sum -c -

    # Install binary into workspace PATH
    chmod +x operator-sdk_${OS}_${ARCH} && sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

elif [ $OPERATOR_INSTALL == "build" ]; then

    # Compile and install from master
    git clone https://github.com/operator-framework/operator-sdk
    cd operator-sdk
    git checkout master
    make install

else

    echo "ERROR: Variable OPERATOR_INSTALL must be either 'download' or 'build' "
    popd
    exit 1

fi

# Return to workspace and check operator-sdk version
popd

echo "Checking operator-sdk"
operator-sdk version
