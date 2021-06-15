timeout(time: 20, unit: 'MINUTES') {
  node {   

    stage("Build Image") {
      openshift.withCluster() {
        openshift.withProject("liberty-demo-pbw-jenkins-pipeline") {
          def deployedAppName = "pbw-liberty-derby-demo"
          echo "Starting build using BuildConfig ${deployedAppName} ..."
          openshift.selector("bc", deployedAppName).startBuild("--wait=true")
        }
      }
    }

    stage('Deploy') {
      openshift.withCluster() {
        openshift.withProject("liberty-demo-pbw-jenkins-pipeline") {
          def deployedAppName = "pbw-liberty-derby-demo"
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
