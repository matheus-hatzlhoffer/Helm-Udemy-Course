# Helm - Package Manager for Kubernetes

This is a repository dedicated to the helm course [Helm - Package Manager for Kubernetes](https://www.udemy.com/course/helm-package-manager-for-kubernetes-complete-master-course/?couponCode=ST15MT31224).

To run helm in this course I am using my machine with wsl2, docker and kuberentes installed. My cluster is a local minikube cluster with 4 nodes.

Helm 3.14.2 is used to the the activities.

## Section 1 - Introduction

Helm is a package manager for Kubernetes designed to deploy all Kubernetes components in the correct order and with the correct dependencies. Helm can encapsulate all configurations in a folder, create templates for customization, and facilitate versioning of the application.

### Some Helm Components

1. Helm Client - Interface through which Helm can be communicated. Facilitates communication with Kubernetes.
2. Charts - Application definitions. A collection of files in a defined structure.
3. Repositories - Store and manage the charts.
4. Release - Chart instance loaded into Kubernetes. Each release will have a version.

Helm v3 interacts with the Kubernetes cluster directly using Role Based Access

### Helm Commands

#### Command to search specific Charts

``` bash
helm search hub
helm search hub <chart_name>
```

#### To search a specific repository

``` bash
helm repo add <repo_name> <repo_url>
helm repo list
helm search repo <repo_name>
helm search repo <repo_name>/<chart_name>
helm repo update
```

#### To install a Chart

``` bash
helm install <repo_name>/<chart_name> --generate-name
helm install <chart_name> <repo_name>/<chart_name> --generate-name
kubectl get all
```

#### To create a Chart

``` bash
helm create <chart_name>
```

## Section 2 - Charts and Templates

You can configure your template with [built-in objects](https://helm.sh/docs/chart_template_guide/builtin_objects/) or with a yaml file with the values.

To run your helm install just to check the values, you can use the debug and dry-run flags

``` bash
helm install --debug --dry-run <chart_name> <chart_folder>
```

To overide a value in the command line you can use the flag --set

``` bash
helm install --set <value_key>=<value> <chart_name> <chart_folder>
```

There are a lot of [function in helm template](https://helm.sh/docs/chart_template_guide/function_list/) to add quotes or convert to uppercase, for example.

It is important to notice that the template defined inside the file follows it's own indentation. It doesn't follow the {{- template}}'s indentation

A . or a $ can pass the context to a template so it can access the variables
