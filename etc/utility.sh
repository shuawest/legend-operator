#!/bin/bash


# Operator SDK 
# - Reference documentation
#   - Install Operator SDK: https://sdk.operatorframework.io/docs/installation/
#   - OLM quickstart: https://sdk.operatorframework.io/docs/olm-integration/quickstart-bundle/
#   - OLM Integration Bundle Tutorial: https://sdk.operatorframework.io/docs/olm-integration/tutorial-bundle/
#   - Go Operator tutorial: https://sdk.operatorframework.io/docs/building-operators/golang/tutorial/

genOperatorInit() {
    checkOperatorSDK
    pushd ${OPERATOR_SRC}
    operator-sdk init --domain ${DOMAIN} --repo ${GOREPO} --project-version=${SDK_PROJECT_VERSION} 
    popd
}

genApis() {
    checkOperatorSDK
    pushd ${OPERATOR_SRC}

    popd
}

checkOperatorSDK() {
    if [ -f "/usr/local/bin/operator-sdk" ]; then
        echo "operator-sdk is installed, version:"
        operator-sdk version
    else
        echo "operator-sdk is not installed yet"
        if [ $OPERATOR_INSTALL == "download" ]; then
            echo "downloading operator-sdk"
            downloadOperatorSDK
        elif [ $OPERATOR_INSTALL == "build" ]; then
            echo "building operator-sdk from source"
            buildOperatorSDK
        else 
            echo "ERROR: Variable OPERATOR_INSTALL must be either 'download' or 'build' "
            exit 1
        fi 
    fi  
}

downloadOperatorSDK() {
    mkdir $SDK_PATH
    pushd $SDK_PATH

    # Download operator-sdk binary
    curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}
    gpg --keyserver keyserver.ubuntu.com --recv-keys 052996E2A20B5C7E
    curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt
    curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt.asc
    gpg -u "Operator SDK (release) <cncf-operator-sdk@cncf.io>" --verify checksums.txt.asc
    grep operator-sdk_${OS}_${ARCH} checksums.txt | sha256sum -c -

    # Install binary into workspace PATH
    chmod +x operator-sdk_${OS}_${ARCH} && sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk
    
    popd

    operator-sdk version
}

buildOperatorSDK() {
    mkdir $SDK_PATH
    pushd $SDK_PATH

    # Compile and install from master
    git clone https://github.com/operator-framework/operator-sdk
    cd operator-sdk
    git checkout master
    make install

    popd

    operator-sdk version
}

# OpenShift

ocadmin() {
    checkOpenShiftClient
	oc login -u ${OC_ADMIN_USER} -p ${OC_ADMIN_PASS} ${OC_API}
}

oclogin() {
    checkOpenShiftClient
	oc login -u ${OC_USER} -p ${OC_PASS} ${OC_API}
}

checkOpenShiftClient() {
    if [ -f "/usr/local/bin/oc" ]; then
        echo "openshift oc client installed."
    else
        echo "installing openshift oc client..."
        ocClientInstall
    fi 
}
ocClientInstall() {
	curl ${OC_CLIENT_DOWNLOAD} --output oc.tar
	tar xvf oc.tar
	sudo mv -f oc /usr/local/bin/oc
	rm -f oc.tar
}


