#/bin/bash

export WLP_PROJECT_NAME='liberty-demo-pbw-jenkins-pipeline'

oc delete project ${WLP_PROJECT_NAME} --wait=true

watch oc get project ${WLP_PROJECT_NAME}
