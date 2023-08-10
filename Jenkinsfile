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
           sh 'docker --version'
           sh 'which docker'
          dockerImage = docker.build dockerimagename
        }
      }
    }


    

   /*
    

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          kubeconfig(serverUrl: 'https://localhost:51125') {
          sh 'kubectl config use-context k3d-one-node-cluster'
          sh 'kubectl apply -f deployment.yaml'
          sh 'kubectl apply -f service.yaml'
      }
         // kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
         
        }
      }
    }
*/
  }

}