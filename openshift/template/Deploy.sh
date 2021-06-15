#/bin/bash

export WLP_PROJECT_NAME='liberty-demo-pbw-custom-deploy'
echo WLP Project: ${WLP_PROJECT_NAME}

export GITHUB_WEBHOOK_SECRET_REF='github-webhook-secret-key'
echo GitHub webhook secret ref: ${GITHUB_WEBHOOK_SECRET_REF}

oc new-project ${WLP_PROJECT_NAME}

oc create secret generic ${GITHUB_WEBHOOK_SECRET_REF} \
  --from-literal=WebHookSecretKey='bWlrZWNhaS1leS1zYW1wbGUtcGxhbnRzYnl3ZWJzcGhlcmU='

oc process -f pbw-liberty-derby-demo-template.yaml \
            -p PROJECT_NAME=${WLP_PROJECT_NAME} \
            | oc create -f -

oc get route

oc start-build pbw-liberty-derby-demo

watch oc get all
