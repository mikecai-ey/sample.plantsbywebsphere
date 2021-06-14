#/bin/bash

#oc delete project liberty-demo-pbw-jenkins-pipeline --wait

export CICD_PROJECT_NAME='jenkins-cicd'
export WLP_PROJECT_NAME='liberty-demo-pbw-jenkins-pipeline'
echo Jenkins CICD Project: ${CICD_PROJECT_NAME}
echo WLP Project: ${WLP_PROJECT_NAME}

oc new-project ${WLP_PROJECT_NAME}

oc process -f pbw-liberty-jenkins-pipeline.yaml \
            -p PROJECT_NAME=${WLP_PROJECT_NAME} \
            -p GITHUB_WEBHOOK_SECRET='Ej6hjWtgeDKMvlHIJJNSOtMSx2vwMXq7UvGwUKjm' \
            -p GENERIC_WEBHOOK_SECRET='Ej6hjWtgeDKMvlHIJJNSOtMSx2vwMXq7UvGwUKjm' \
            | oc create -f -

oc policy add-role-to-user edit system:serviceaccount:${CICD_PROJECT_NAME}:jenkins -n ${WLP_PROJECT_NAME}
