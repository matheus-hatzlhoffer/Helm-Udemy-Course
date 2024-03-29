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

## Section 3 - Chart Repository

To create a local chart repository with Chartmuseum.

To add the chrtmuseum repository

``` bash
chartmuseum --debug --port=8080 --storage=local --storage-local-rootdir="./chartstorage"
helm repo add <repo_name> http://localhost:8080
```

To create a package and store in the repository

``` bash
helm package <chart_folder>/
curl --data-binary "@<chart_folder>-<chart_version>.tgz" http://localhost:8080/api/charts
helm repo update
helm search repo -l <repo_name>
```

## Section 4 - Chart Management

To manage the helm chart, these commands can be used:

``` bash
helm upgrade <chart_name> <chart_repo>/<chart_name>
helm rollback <chart_name> <revision_number>
helm history <chart_name>
```

To add dependencies within the chart, declare it in the Chart.yaml

``` yaml
dependencies:
  - name: mariadb
    version: 16.x.x
    repository: https://charts.bitnami.com/bitnami
```

``` bash
helm dependency update ./<chart_folder>
helm dependency build ./<chart_folder>
```

### Hooks

- Pre-Install - Hooks run after templates are rendered and before any resources are created in kubernetes
- Post-Install - Hooks run after all resources are loaded in kubernetes
- Pre-Delete - Hooks run before any resources are deleted in kubernetes
- Post-Delete - Hooks run after all resources are deleted in kubernetes
- Pre-Upgrade - Hooks run after templates are rendered and before any resources are upgraded in kubernetes
- Post-Upgrade - Hooks run after all resources are upgraded in kubernetes
- Pre-Rollback - Hooks run after templates are rendered and before any resources are rolled back in kubernetes
- Post-Rollback - Hooks run after all resources are rolled back in kubernetes

For weighted hooks, those with lower wights are executed before than the highers

## Section 5 - Testing and Verification

To check for error and warnings in the chart folder run the command

``` bash
helm lint <chart_folder>
```

To test run

``` bash
helm test <chart_name>
```

The tests are stored in the tests folder inside the templates

The getters and status:

``` bash
helm get values <chart_name>
helm get notes <chart_name>
helm get manifesto <chart_name>
helm get hooks <chart_name>
helm status <chart_name>
```
