#/bin/bash

# oc delete project jenkins-cicd --wait

export CICD_PROJECT_NAME='jenkins-cicd'
echo ${CICD_PROJECT_NAME}

oc new-project ${CICD_PROJECT_NAME}

oc new-app jenkins-ephemeral \
            --param MEMORY_LIMIT=2Gi \
            --param DISABLE_ADMINISTRATIVE_MONITORS=true \
            --param ENABLE_OAUTH=true \
            --as-deployment-config=true

oc set resources dc jenkins --limits=cpu=2 --requests=cpu=1,memory=2Gi

oc get route jenkins -o jsonpath='{.spec.host}{"\n"}'

watch oc get all
