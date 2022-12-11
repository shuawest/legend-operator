#!/bin/sh

# Operator codegen config

export OPERATOR_NAME=legend-operator
export OPERATOR_SRC=/workspaces/legend-operator/src

export OPERATOR_VERSION=v0.0.1

export DOMAIN=org.finos.legend
export NAME="finos-legend"
export GOREPO=github.com/finos/legend-operator
export OPAPI_VERSION=v1alpha1

export SDK_PROJECT_VERSION=3


# Operator SDK Config

export OPERATOR_INSTALL="download" # "download|build"
export SDK_PATH=/workspaces/operator-sdk  # assumes github codespaces

export OPERATOR_SDK_VERSION=v1.26.0
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}


# Derived variables

export OPERATOR_IMAGE=${REGISTRY}/${REGISTRY_USER}/${OPERATOR_NAME}:${OPERATOR_VERSION}
export OPERATOR_BUNDLE=${REGISTRY}/${REGISTRY_USER}/${OPERATOR_NAME}-bundle:${OPERATOR_VERSION}

export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')


# Runtime and framework config

export GO111MODULE=on
export GOPROXY="https://proxy.golang.org|direct"

