pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsapps"
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
        docker('docker') {
            dockerImage = docker.build dockerimagename
        // docker.build dockerimagename+ ":$BUILD_NUMBER"
        // dockerImage = docker.build("dockerimagename:latest")
       // 
       //docker.withDockerContainer('my-imagesss:latest')
       // dockerImage = docker.build("my-imagesss:latest")
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