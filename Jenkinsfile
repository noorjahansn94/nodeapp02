pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsapps"
    dockerImage = ""
  }
  agent {
    kubernetes {
      label 'docker'
      image 'docker'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
      tag 'dind'
      command '/bin/sh -c /usr/local/bin/dockerd-entrypoint.sh'
      TTYEnabled true
      privileged true
    }
  }
  //agent any
 // agent {
    // kubernetes {
    //   label 'docker'
    //   defaultContainer 'jnlp'
    // }
    // docker {
    //         image 'docker:dind'
    //         args '-v /var/run/docker.sock:/var/run/docker.sock'
    //     }
 // }

  stages {

    stage('Checkout Source') {
      steps {
      //  git 'https://github.com/noorjahansn94/nodeapp02.git'
      git branch: 'main', url: 'https://github.com/noorjahansn94/nodeapp02.git'
      }
    }

    stage('Build image') {
      steps{
        sh 'docker --version'
        //sh 'docker build -t my-image .'
        sh 'dockerd &'
        sh 'sleep 10'
         script{
         docker.build("my-imagesss:latest")
         }
       // docker('docker') {


        // dockerBuild(
        //     dockerfile: 'Dockerfile',
        //     image: 'noorjahansn/nodejsapps'
        //     tag: 'latest'
        // )
       // }
      
      }
    }

   /*
    stage('Build image') {
      steps{
        docker('docker') {
          //  sh docker build -t my-image .
         //   dockerImage = docker.build dockerimagename
         //docker.build dockerimage+ ":$BUILD_NUMBER"
        // dockerImage = docker.build("dockerimagename:latest")
       // 
       //
        docker.build("my-imagesss:latest")
        }
      }
    }

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