#/bin/bash

oc project liberty-demo-pbw-custom-deploy

oc create secret generic quay.io-mikecai-ey.rh-ocp-ey \
    --from-file=.dockerconfigjson=./mikecai-ey-rh-ocp-ey-auth.json \
    --type=kubernetes.io/dockerconfigjson

oc create -f pbw-liberty-deploy.yaml

# oc expose service pbw-liberty-derby-demo

oc get route