pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsappeg"
    dockerImage = ""
 
  }
  //agent any
   agent {
     label 'docker'

   }
  //  tools {
  //       // Define Docker tool installation named 'docker'
  //       dockerTool 'docker'
  //   }
  //  agent {
  //    kubernetes {
  //      label 'docker'
  //      defaultContainer 'jnlp'
  //    }
  //  }


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
          sh 'docker info'
           sh 'docker --version'
           sh 'which docker'
          dockerImage = docker.build dockerimagename
          }
        }
      }
    }


    

   
    

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          container('dind') {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("v1")
          }
          }
        }
      }
    }

    
          // kubeconfig(serverUrl: 'https://localhost:51125') {
          // sh 'kubectl config use-context k3d-one-node-cluster'
          // sh 'kubectl apply -f deployment.yaml'
          // sh 'kubectl apply -f service.yaml'
    stage('Deploying App to Kubernetes') {
      steps {
        script {
                    def kubeconfig = readFile("${JENKINS_HOME}/.kube/config") // Path to your kubeconfig file
                    sh "echo '\$kubeconfig' > kubeconfig.yaml" // Write kubeconfig to a file

                    // Apply your Kubernetes resources using kubectl
                    sh "kubectl apply -f deployment.yaml -f service.yaml --kubeconfig kubeconfig.yaml"
                }
      //   script {
      //     kubernetes(configs: "deployment.yaml service.yaml", kubeconfigId: "kubernetes")
      // }
         // kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
         
        }
      }
    }

  }


/*
script {
                    def kubeconfig = readFile("${JENKINS_HOME}/.kube/config") // Path to your kubeconfig file
                    sh "echo '\$kubeconfig' > kubeconfig.yaml" // Write kubeconfig to a file

                    // Apply your Kubernetes resources using kubectl
                    sh "kubectl apply -f deployment.yaml -f service.yaml --kubeconfig kubeconfig.yaml"
                }
*/
