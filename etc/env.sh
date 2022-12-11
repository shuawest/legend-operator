#!/bin/sh

export OPERATOR_NAME=legend-operator
export OPERATOR_PATH=/workspaces/legend/installers/k8s/operator/${OPERATOR_NAME}

export REGISTRY=quay.io
export REGISTRY_USER=jaydbyoo
export VERSION=0.0.1

export DOMAIN=org.finos.legend
export NAME="finos-legend"
export REPO=github.com/shuawest/legend-operator
export OPAPI_VERSION=v1alpha1

# OpenShift
export OC_DOMAIN=cluster-h8ktl.h8ktl.sandbox1405.opentlc.com


# Derived variables
export OC_API=api.${OC_DOMAIN}
export OC_DOWNLOAD=https://downloads-openshift-console.apps.${OC_DOMAIN}/amd64/linux/oc.tar

export OPERATOR_VERSION=v${VERSION}
export OPERATOR_IMAGE=${REGISTRY}/${REGISTRY_USER}/${OPERATOR_NAME}:${OPERATOR_VERSION}
export OPERATOR_BUNDLE=${REGISTRY}/${REGISTRY_USER}/${OPERATOR_NAME}-bundle:${OPERATOR_VERSION}



# Runtime variables
export GO111MODULE=on
export SDK_VERSION=3
