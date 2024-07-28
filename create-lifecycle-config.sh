#!/bin/bash

# Create lifecycle configuration
# Refer to: https://github.com/aws-samples/sagemaker-studio-apps-lifecycle-config-examples/tree/main/jupyterlab/auto-stop-idle
mkdir -p tmp
cd tmp/

ASI_VERSION=0.3.1
curl -LO https://github.com/aws-samples/sagemaker-studio-apps-lifecycle-config-examples/releases/download/v$ASI_VERSION/jupyterlab-lccs-$ASI_VERSION.tar.gz
tar -xvzf jupyterlab-lccs-$ASI_VERSION.tar.gz

cd auto-stop-idle/

LCC_NAME=jupyter-lab-auto-stop-idle
LCC_CONTENT=`openssl base64 -A -in on-start.sh`

aws sagemaker create-studio-lifecycle-config \
    --studio-lifecycle-config-name $LCC_NAME \
    --studio-lifecycle-config-content $LCC_CONTENT \
    --studio-lifecycle-config-app-type JupyterLab \
    --query 'StudioLifecycleConfigArn'

cd ../../
rm -rf tmp/