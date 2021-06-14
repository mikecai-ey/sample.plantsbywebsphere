pipeline {

  tools {
    oc 'oc'
  }

  agent any

  stages {   

    stage("Checkout") {
      steps {
        checkout scm
      }
    }

    stage("Build Image") {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject("${env.PROJECT_NAME}") {
              def deployedAppName = "${env.APP_NAME}"
              echo "Starting build using BuildConfig ${deployedAppName} ..."
              openshift.selector("bc", deployedAppName).startBuild("--from-dir=.", "--wait=true")
            }
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject("${env.PROJECT_NAME}") {
              def deployedAppName =  "${env.APP_NAME}"
              echo "Perform a rolling update of newly built image on current deployment ..."
              def rm = openshift.selector("dc",deployedAppName).rollout().latest()
              echo "Wait for Deployment to start rolling out and then wait for it to complete ..."
              sleep 60
              timeout(5) {
                openshift.selector("dc", deployedAppName).related('pods').untilEach(1) {
                  return (it.object().status.phase == "Running")
                }
              }
            }
          }
        }
      }
    }
  }
}
