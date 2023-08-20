# Deploying application in Kubernetes using Jenkins

[![Build Status](https://jenkins.example.com/buildStatus/icon?job=Your-Job-Name)](https://jenkins.example.com/job/Your-Job-Name/)

This project includes example demo for deploying an app in kubernetes using Jenkins

<!-- ## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Configure and Install Jenkins](#Configure-and-Install-Jenkins)
- [Contributing](#contributing)
- [License](#license) -->

## Overview

A concise description of what this Jenkins project is about, its purpose, and its benefits. You can include any relevant context here.

## Prerequisites
1. Kubernetes cluster (K3D used in this project)
2. Helm installed in your machine
3. Docker desktop installed in your machine

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


2. Pull official helm repository into a folder.

    ```shell
    helm pull jenkins/jenkins
    ```
3. jenkins-4.5.0.tgz will be downloaded and extract this downloaded file to get Jenkins folder in which it   contains the helm chart
4. Ensure Helm is properly installed by running the following command. 

    ```shell
    helm version
    ```
## Modify the helm chart

Inorder to run the docker commands and kubectl commands, we need to modify the helm chart to include additional two containers: One container with docker:dind image to run docker commands and another with bitnami/kubectl image to run kubectl commands. Modify the helm chart values by adding the following to values.yaml file:

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
1. In order to access the kubernetes cluster from the jenkins pod, a service account is needed. Modify the helm chart values.yaml by adding the following in the serviceAccountAgent section:
  ```shell
  serviceAccountAgent:
  create: true
  name: testsc   #service account name
  annotations: {}
  extraLabels: {}
  imagePullSecretName:
  ```
2. Permissions to this service account must be added to rbac.yaml file in the helm chart. Only then we will be able to apply the deployments and services inside the cluster. Add the following in the rules section of jenkins\templates\rbac.yaml file:

  ```shell
  rules:
- apiGroups: [""]
  resources: ["pods", "pods/exec", "pods/log", "persistentvolumeclaims", "events"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["pods", "pods/exec", "persistentvolumeclaims"]
  verbs: ["create", "delete", "deletecollection", "patch", "update"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["create", "get", "list", "update", "delete", "patch"]
- apiGroups: [""]
  resources: ["services"]
  verbs: ["create", "get", "list", "update", "delete"]
  ```  

3. Install the helm chart from the directory:
```shell
helm install my-release ./jenkins
```
4. The following credentials are used to login to Jenkins:
 username: admin
 To get password, run the following command:
 ```shell
 kubectl exec --namespace default -it svc/my-jenkins-eg -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
 ```
5. run the following command in the same shell
```shell
kubectl --namespace default port-forward svc/my-release-jenkins 8080:8080
```
6. Open http://127.0.0.1:8080 in the browser, give the credentials and login to jenkins UI.
