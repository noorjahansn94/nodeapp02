pipeline {

  environment {
    dockerimagename = "noorjahansn/nodejsappeg"
    dockerImage = ""
    KUBECONFIG = credentials('kube-credentials')
    KUBE_SERVER_URL = 'http://localhost:51125'
    // PATH = "${tool name: 'kubectl', type: 'ToolType'}:${env.PATH}"
 
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
     }
   }


  stages {

    stage('Checkout Source') {
      steps {
      //  git 'https://github.com/noorjahansn94/nodeapp02.git'
      git branch: 'main', url: 'https://github.com/noorjahansn94/nodeapp02.git'
      }
    }
    

    // stage('Build image') {
    //   steps{
    //     script {
    //       container('dind') {
    //       sh 'docker info'
    //        sh 'docker --version'
    //        sh 'which docker'
    //       dockerImage = docker.build dockerimagename
    //       }
    //     }
    //   }
    // }


    

   
    

    // stage('Pushing Image') {
    //   environment {
    //            registryCredential = 'dockerhub-credentials'
    //        }
    //   steps{
    //     script {
    //       container('dind') {
    //       docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
    //         dockerImage.push("v1")
    //       }
    //       }
    //     }
    //   }
    // }

 stage('Deploying App to Kubernetes') {
      steps {
        container('kubectl'){
        script {
          sh 'kubectl config use-context k3d-one-node-cluster'
          kubernetes(configs: "deployment.yaml service.yaml", kubeconfigId: $KUBECONFIG)
      }
        }  
         
        }
      }



        // stage('Deploy App with Kubernetes Agent') {
        //     steps {
        //         script {
        //           container('kubectl'){
        //              withKubeConfig(credentialsId: 'kube-credentials') {
        //               sh 'kubectl config use-context k3d-one-node-cluster'
        //               sh 'kubectl get po'
        //               sh 'kubectl apply -f deployment.yaml'
        //             }
        //         }
        //     }
        // }
        // }




    // stage('Deploy to Kubernetes') {
    //         steps {
    //             script {
    //               container('kubectl'){
    //                 def kubeconfigContent = credentials('kube-credentials')
    //                 sh """ 
    //                 echo "$KUBECONFIG" > kubeconfig.yaml
    //                 kubectl apply -f deployment.yaml --kubeconfig=kubeconfig.yaml
    //                 """
       
    //             }
    //         }
    //     }
    // }
    // stage('Apply Kubernetes files') {
    //   steps{
    //     script {
    //       container('kubectl'){
    //         echo "first command start"
    //         sh 'kubectl version'

           
            
          //  withCredentials([file(credentialsId: 'kube-credentials', variable: 'KUBECONFIG')]) {
      // Set the KUBECONFIG environment variable to the temporary file path
      // sh "export KUBECONFIG=$HOME/.kube/config"
      // echo "KUBECONFIG value: ${env.KUBECONFIG}"
     // sh "kubectl config set-cluster k3d-one-node-cluster --server=${env.KUBE_SERVER_URL}"

      // Run kubectl commands using the kubeconfig
      // echo "available contexts:"
      // sh 'kubectl config get-contexts'
      // echo "availa context in pod?????"
      // sh 'kubectl config get-contexts --kubeconfig=/home/jenkins/.kube/config'
      // sh 'kubectl config use-context k3d-one-node-cluster --server=http://localhost:51125 --kubeconfig=${env.KUBECONFIG}'
      // sh 'kubectl get pods'
      // sh 'kubectl apply -f deployment.yaml'
      // }




        //  def kubeconfigPath = sh(script: "echo \$KUBECONFIG_CREDENTIALS", returnStdout: true).trim()
        //  echo "first command end"
        //  echo "second command start"
        //  kubernetes(configs: "deployment.yaml service.yaml", kubeconfigPath: kubeconfigPath)
        //  echo "second command end"
          
         //kubernetes(configs: "deployment.yaml service.yaml", kubeconfigId: "kube-credentials")
         //def kubeconfigPath = sh(script: "echo \$KUBECONFIG_CREDENTIALS", returnStdout: true).trim()
         //kubernetes(configs: "deployment.yaml service.yaml", kubeconfigPath: kubeconfigPath)
       //  }
    // withCredentials([file(credentialsId: 'kube-credentials', variable: 'KUBECONFIG')]) {
    //   // Set the KUBECONFIG environment variable to the temporary file path
    //   sh "export KUBECONFIG=${KUBECONFIG}"
    //   echo "KUBECONFIG value: ${env.KUBECONFIG}"

    //   // Run kubectl commands using the kubeconfig
    //   sh 'kubectl apply -f deployment.yaml'
    // }
  //}
  //  }

          // kubeconfig(serverUrl: 'https://localhost:51125') {
          // sh 'kubectl config use-context k3d-one-node-cluster'
          // sh 'kubectl apply -f deployment.yaml'
          // sh 'kubectl apply -f service.yaml'
   
  //  }

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
