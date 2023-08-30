# Deploying application in Kubernetes using Jenkins

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Create a Kubernetes Cluster](#Create-a-Kubernetes-Cluster)
- [Install Helm](#Install-Helm)
- [Modify the helm chart](#Modify-the-helm-chart)
- [Create Service Account](#Create-a-Service-Account-with-permissions)
- [App deployment to kubernetes](#app-deployment-to-kubernetes)
- [Jenkins Configuration](#Jenkins-Configuration)
- [Access the application](#Access-the-application)



## Overview

This guide will take you through the steps necessary to build and deploy an application in Kubernetes using Jenkins

## Prerequisites
1. Kubernetes (K3D used in this project)
2. Docker desktop installed and running in your machine

## Create a Kubernetes Cluster
    
1. Provision the cluster with `K3D`
k3d is a lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker. Use K3D to create and manage the Kubernetes cluster, named `k3d-one-node-cluster`
```shell
k3d cluster create one-node-cluster --agents 1
```

## Install Helm

In this lab, we will use Helm to install Jenkins .  Helm
is a package manager that makes it easy to configure and deploy Kubernetes
applications.  Once we have Jenkins installed, we'll be able to set up our
CI/CD pipleline.

1. Install helm

    ```shell
    choco install kubernetes-helm
    ```
2. Ensure Helm is properly installed by running the following command. 

    ```shell
    helm version
    ```
3. Create a directory to save the helm repo:
 ```shell
    mkdir helm-release
 ```
4. Once Helm is set up properly, add the repository as follows:
```shell
  helm repo add jenkins https://charts.jenkins.io
  helm repo update
```
5. Pull official helm repository into the `helm-release` directory.

```shell
    helm pull jenkins/jenkins
```
6. Extract the downloaded `jenkins-4.5.0.tgz` file to get the helm chart folder named `Jenkins`. 

## Modify the helm chart

Inorder to run the docker commands and kubectl commands, we need to modify the helm chart to include additional two containers: One container with docker:dind image to run docker commands and another with bitnami/kubectl image to run kubectl commands. Modify the helm chart values by adding the following to `values.yaml` file:

  ```shell
  additionalContainers: 
    - sideContainerName: dind
      image: docker
      tag: dind
      command: dockerd-entrypoint.sh
      args: "--host=unix:///var/run/docker.sock"
      privileged: true
      resources:
        requests:
          cpu: 500m
          memory: 0.5Gi
        limits:
          cpu: 1
          memory: 2Gi
    - sideContainerName: kubectl
      image: bitnami/kubectl
      tag: latest
      args: "infinity"
      command: "sleep"
      resources:
        requests:
          cpu: 500m
          memory: 0.5Gi
        limits:
          cpu: 1
          memory: 2Gi
  ```
## Create a Service Account with permissions
1. In order to access the kubernetes cluster from the jenkins pod, a service account is needed. Modify the helm chart `values.yaml` by adding the following in the serviceAccountAgent section:
  ```shell
  serviceAccountAgent:
  create: true
  name: testsc   #service account name
  annotations: {}
  extraLabels: {}
  imagePullSecretName:
  ```
2. Permissions to this service account must be added to rbac.yaml file in the helm chart. Only then we will be able to apply the deployments and services inside the cluster. Add the following in the rules section of `jenkins\templates\rbac.yaml` file:

  ```shell
  rules:
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["create", "get", "list", "update", "delete", "patch"]
- apiGroups: [""]
  resources: ["services"]
  verbs: ["create", "get", "list", "update", "delete","patch"]
  ```  
Add the following to 'subjects' under 'RoleBinding' section of the same rbac.yaml file:
  ```shell
  subjects:
- kind: ServiceAccount
  name: testsc
  namespace: {{ template "jenkins.agent.namespace" . }}
  ```

3. Go to the `helm-release` directory. Install the helm chart by running the following command where `my-release` is the name for helm release and `./jenkins` is the path to the Helm chart directory that we're installing:
```shell
helm install my-release ./jenkins
```
4. The following credentials are used to login to Jenkins:
 username: `admin`
 To get password, run the following command:
 ```shell
 kubectl exec --namespace default -it svc/my-jenkins-eg -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
 ```
5. run the following command in the same shell
```shell
kubectl --namespace default port-forward svc/my-release-jenkins 8080:8080
```
6. Open http://127.0.0.1:8080 in the browser, give the credentials from step 4 and login to jenkins UI.

## App deployment to kubernetes
We'll use a very simple nodejs application for this demo. The dockerfile for the app is located in this repo that can create an image out of the nodejs app. The Jenkinsfile which is written to build the image and deploy it to kubernetes is also placed in the same repo. A Kubernetes Service Deployment YAML file and service YAML file is created and placed in the repo.  We will use the Kubernetes Service to access the node.js application container from outside the Kubernetes cluster. 

## Jenkins Configuration
 
1. Install docker pipeline plugin
  In the Jenkins UI, Go to manage jenkins. Next, click 'Manage Plugins'. Search for Docker Pipeline. Then click the 'Install without restart button':
2. Add Credentials to Jenkins Credentials Manager
We will add the  Docker Hub credentials to the Jenkins Credentials manager using the following steps:
 1. Go back to the Jenkins Dashboard and click 'Manage Jenkins'.
 2. Click 'Manage Credentials'. Click ‘Add Credentials’.
 3. Add Docker Hub username and password and click 'Create' button

 ### Create Pipeline
 We'll now use Jenkins to define and run a pipeline that will  build and and deploy the nodejs app to Kubernetes cluster.
 To create a pipeline, follow the steps:
 1. Open the Jenkins Dashboard and Click 'New Item'.
 2. Enter an item name, for eg: 'nodejsjenkinspipeline'
 3. Select 'Pipeline' then click 'OK'.
 4. In general configuration, under pipeline section, open the drop down from definition, select Pipeline script from SCM.
 5. For SCM, select Git from drop down
 6. Give the repository URL as `https://github.com/noorjahansn94/nodeapp02.git`
 7. Enter `*/main` for branch specifier
 8. Enter `Jenkinsfile` in the Script Path
 9. Click on Save
 10. To build the Pipeline, click 'Build Now'
 11. To get the Pipeline output, click 'Console Ouput'

 The Jenkins CI/CD pipeline outputs a 'SUCCESS' message. The Jenkins CI/CD pipeline was able to: 
1. Build the Docker image.
2. Push the Docker image to Docker Hub.
3. Pull the Docker image from the Docker Hub repository and create a containerized application.
4. Deploy the containerized application to the Kubernetes cluster. 

## Access the application
We will use the Kubernetes Service to access the node.js application container from outside the Kubernetes cluster.
1. To get the Kubernetes Service, run this command:
```shell
kubectl get service
```
output:

```output
service   NodePort    10.43.122.167   <none>  3000:30000/TCP   2d14h 
```

2. Use port forwarding in your local machine using the following command:
```shell
kubectl port-forward service/service 3000:3000
```
3. Use the following URL in your browser to access the application:
```shell
http://127.0.0.1:3000
```


