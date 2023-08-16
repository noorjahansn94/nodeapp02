pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsappeg"
    dockerImage = ""
    KUBECONFIG_CREDENTIALS = credentials('kube-credentials')
    KUBE_SERVER_URL = 'https://localhost:51125'
    // PATH = "${tool name: 'kubectl', type: 'ToolType'}:${env.PATH}"
 
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
  //     // defaultContainer 'jnlp'
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

    stage('Apply Kubernetes files') {
      steps{
        script {
          container('kubectl'){
            echo "first command start"
            sh 'kubectl version'

           
            
            withCredentials([file(credentialsId: 'kube-credentials', variable: 'KUBECONFIG')]) {
      // Set the KUBECONFIG environment variable to the temporary file path
      sh "export KUBECONFIG=${KUBECONFIG}"
      echo "KUBECONFIG value: ${env.KUBECONFIG}"
      sh "kubectl config set-cluster k3d-one-node-cluster --server=${KUBE_SERVER_URL}"

      // Run kubectl commands using the kubeconfig
      
      sh 'kubectl config use-context k3d-one-node-cluster'
      sh 'kubectl apply -f deployment.yaml'
      }




        //  def kubeconfigPath = sh(script: "echo \$KUBECONFIG_CREDENTIALS", returnStdout: true).trim()
        //  echo "first command end"
        //  echo "second command start"
        //  kubernetes(configs: "deployment.yaml service.yaml", kubeconfigPath: kubeconfigPath)
        //  echo "second command end"
          
         //kubernetes(configs: "deployment.yaml service.yaml", kubeconfigId: "kube-credentials")
         //def kubeconfigPath = sh(script: "echo \$KUBECONFIG_CREDENTIALS", returnStdout: true).trim()
         //kubernetes(configs: "deployment.yaml service.yaml", kubeconfigPath: kubeconfigPath)
         }
    // withCredentials([file(credentialsId: 'kube-credentials', variable: 'KUBECONFIG')]) {
    //   // Set the KUBECONFIG environment variable to the temporary file path
    //   sh "export KUBECONFIG=${KUBECONFIG}"
    //   echo "KUBECONFIG value: ${env.KUBECONFIG}"

    //   // Run kubectl commands using the kubeconfig
    //   sh 'kubectl apply -f deployment.yaml'
    // }
  }
    }

          // kubeconfig(serverUrl: 'https://localhost:51125') {
          // sh 'kubectl config use-context k3d-one-node-cluster'
          // sh 'kubectl apply -f deployment.yaml'
          // sh 'kubectl apply -f service.yaml'
    // stage('Deploying App to Kubernetes') {
    //   steps {
        
    //   //   script {
    //   //     kubernetes(configs: "deployment.yaml service.yaml", kubeconfigId: "kube-credentials")
    //   // }
    //      // kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
         
    //     }
    //   }
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
