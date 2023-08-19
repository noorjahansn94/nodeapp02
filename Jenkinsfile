pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsappeg"
    dockerImage = ""
    registryCredential = 'dockerhub-credentials'
    imageVersion = "${env.JOB_NAME}_v${env.BUILD_NUMBER}"
  }
  
  agent any
 

  stages {

    stage('Checkout Source') {
      steps {
      git branch: 'main', url: 'https://github.com/noorjahansn94/nodeapp02.git'
      
      }
    }
    

    stage('Build image') {
      steps{
        script {
          container('dind') {
          // sh 'docker info'
          //  sh 'docker --version'
          dockerImage = docker.build dockerimagename
          }
        }
      }
    }

    stage('Pushing Image') {
      steps{
        script {
          container('dind') {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
         // def imageVersion = "${env.JOB_NAME}_v${env.BUILD_NUMBER}"
          dockerImage.push(imageVersion)
          sh "sed -i 's#IMAGE_VERSION_PLACEHOLDER#${imageVersion}#g' deployment.yaml"

          }
          }
        }
      }
    }



        stage('Deploy App with Kubernetes Agent') {
            steps {
                script {
                  container('kubectl'){
                  def serviceAccountToken = readFile('/var/run/secrets/kubernetes.io/serviceaccount/token')
                 // echo "Service Account Token: ${serviceAccountToken}"
                  sh """
                      kubectl --token=${serviceAccountToken} get pods
                      kubectl --token=${serviceAccountToken} apply -f deployment.yaml
                      kubectl --token=${serviceAccountToken} apply -f service.yaml

                    """

                  
                    }
                }
            }
        }
        }


  }

 //  agent {
  //    label 'docker'
  // }
  
  //  agent {
  //    kubernetes {
  //      label 'docker'
  //     // defaultContainer 'jnlp'
  //    }
  //  }

