#/bin/bash

oc new-project liberty-demo-pbw-custom-deploy

oc create secret generic github-webhook-secret-key \
  --from-literal=WebHookSecretKey='bWlrZWNhaS1leS1zYW1wbGUtcGxhbnRzYnl3ZWJzcGhlcmU='

oc create -f ./BuildConfig.yaml
oc create -f ./ImageStream.yaml
oc create -f ./DeploymentConfig.yaml
oc create -f ./Service.yaml
oc create -f ./Route.yaml

oc start-build pbw-liberty-derby-demo

oc get route


# oc create secret generic quay.io-mikecai-ey.rh-ocp-ey \
#     --from-file=.dockerconfigjson=./mikecai-ey-rh-ocp-ey-auth.json \
#     --type=kubernetes.io/dockerconfigjson

#oc create -f pbw-liberty-deploy.yaml

# oc expose service pbw-liberty-derby-demo

