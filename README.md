# Deploying application in Kubernetes using Jenkins

[![Build Status](https://jenkins.example.com/buildStatus/icon?job=Your-Job-Name)](https://jenkins.example.com/job/Your-Job-Name/)

This project includes example demo for deploying an app in kubernetes using Jenkins

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Overview

A concise description of what this Jenkins project is about, its purpose, and its benefits. You can include any relevant context here.

## Prerequisites
1. Kubernetes cluster (K3D used in this project)
2. Helm installed in your machine
3. Docker desktop installed in your machine

## Install Helm

In this lab, you will use Helm to install Jenkins with a stable _chart_.  Helm
is a package manager that makes it easy to configure and deploy Kubernetes
applications.  Once you have Jenkins installed, you'll be able to set up your
CI/CD pipleline.

1. Download and install the helm binary

    ```shell
    wget https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
    ```

1. Unzip the file to your local system:

    ```shell
    tar zxfv helm-v3.2.1-linux-amd64.tar.gz
    cp linux-amd64/helm .
    ```

1. Add the official stable repository.

    ```shell
    ./helm repo add stable https://kubernetes-charts.storage.googleapis.com
    ```

1. Ensure Helm is properly installed by running the following command. You
   should see version `v3.2.1` appear:

    ```shell
    ./helm version
    ```

    Output (do not copy):

    ```output
    version.BuildInfo{Version:"v3.2.1", GitCommit:"fe51cd1e31e6a202cba7dead9552a6d418ded79a", GitTreeState:"clean", GoVersion:"go1.13.10"}
    ```

## Usage

Explain how to use your Jenkins project. This might include:

- How to trigger the Jenkins job
- Any parameters or input required
- Expected outputs and behavior
- Relevant screenshots or diagrams

Remember to provide clear and concise instructions to make it easy for users to understand and utilize your project.

## Configuration

If there are any specific configurations or customization options, explain them in this section. You can cover topics like:

- Environment variables
- Jenkinsfile structure
- Custom pipelines and stages

Make sure to include examples and explanations for better clarity.

## Contributing

Explain how others can contribute to your Jenkins project. Include:

- Guidelines for submitting issues and pull requests
- Contribution requirements (e.g., coding standards, tests)
- How to set up a development environment

Encourage collaboration and make it easy for others to contribute effectively.

## License

Specify the license under which your Jenkins project is distributed. You can use the GitHub license badge to provide a quick link to the full license text.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

© [Your Name or Organization]
