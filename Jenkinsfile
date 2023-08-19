pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsappeg"
    dockerImage = ""
    registryCredential = 'dockerhub-credentials'
   // KUBECONFIG = credentials('kube-credentials')
   // KUBE_SERVER_URL = 'http://localhost:51125'
    //KUBECONFIG = "/var/run/secrets/kubernetes.io/serviceaccount/token"
    // PATH = "${tool name: 'kubectl', type: 'ToolType'}:${env.PATH}"
    //KUBE_CREDENTIALS = credentials('6ae336af-71d5-49ee-b60f-1cf49b7ef1c0')
 
  }
  //agent any
  //  agent {
  //    label 'docker'
  // }
  //  tools {
  //       // Define Docker tool installation named 'docker'
  //       dockerTool 'docker'
  //   }
   agent {
     kubernetes {
       label 'docker'
      // defaultContainer 'jnlp'
      serviceAccount 'jenkins'
     }
   }


  stages {

    stage('Checkout Source') {
      steps {
         
      //  git 'https://github.com/noorjahansn94/nodeapp02.git'
      git branch: 'main', url: 'https://github.com/noorjahansn94/nodeapp02.git'
      
      }
    }
    

    stage('Build image') {
      steps{
        script {
          container('dind') {
          // sh 'docker info'
          //  sh 'docker --version'
          //  sh 'which docker'
          dockerImage = docker.build dockerimagename
          }
        }
      }
    }


    

   
    

    stage('Pushing Image') {
      // environment {
      //          registryCredential = 'dockerhub-credentials'
      //      }
      steps{
        script {
          container('dind') {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
           
          dockerImage.push("v${env.BUILD_NUMBER}")
          def imageVersion = "v${env.BUILD_NUMBER}"
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



