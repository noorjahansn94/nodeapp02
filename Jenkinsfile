pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsapp"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
      //  git 'https://github.com/noorjahansn94/nodeapp02.git'
      git branch: 'main', url: 'https://github.com/noorjahansn94/nodeapp02.git'
      }
    }

    stage('Build image') {
      steps{
       // script {
         // dockerImage = docker.build dockerimagename
        // dockerImage = docker.build("dockerimagename:latest")
       // }
       dockerTool('Docker'){
        sh 'docker build -t dockerimagename:latest .'
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
          kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        }
      }
    }
*/
  }

}