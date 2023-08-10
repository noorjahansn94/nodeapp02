pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsappeg"
    dockerImage = ""
   // DOCKER_HOST = 'localhost:2375'
  }
//  agent any
  agent {
    label 'docker'
//    //docker { image 'docker:dind' }
  }
  //  agent {
  //    kubernetes {
  //      label 'docker'
  //      defaultContainer 'jnlp'
  //    }
  //  }
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
        script {
          //dockerImage = docker.build dockerimagename
         sh 'docker --version'
         sh 'which docker'
         sh 'docker build -t noorjahansn/nodejsappeg .'
        }
      }
    }
  

    // stage('docker version') {
    //   steps {
    //   //  git 'https://github.com/noorjahansn94/nodeapp02.git'
    //   sh 'docker --version'
    //   sh 'which docker'
    //   //node('docker') {
    //     git branch: 'main', url: 'https://github.com/noorjahansn94/nodeapp02.git'
    //     sh 'docker --version'
    //     script {
    //        dockerImage = docker.build dockerimagename
    //      }
    //   //}
    //   //sh 'docker start'
    //   //sh 'docker build -t my-image .'
    //   }
    // }
/*
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
*/

    // stage('Build image') {
    //   steps{
    //     sh 'docker --version'
    //     //sh 'docker build -t my-image .'
    //     sh 'dockerd &'
    //     sh 'sleep 10'
    //      script{
    //      docker.build("my-imagesss:latest")
    //      }
    //    // docker('docker') {


    //     // dockerBuild(
    //     //     dockerfile: 'Dockerfile',
    //     //     image: 'noorjahansn/nodejsapps'
    //     //     tag: 'latest'
    //     // )
    //    // }
      
    //   }
    // }

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