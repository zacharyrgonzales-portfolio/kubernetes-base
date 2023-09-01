# kubernetes-base

This project houses ArgoCD bootstrap templates, projects, and k8s base applications.

## Directory Structure

There are three directories; apps, bootstrap, and projects

```
kubernetes-base
├── apps
│   ├── app1
│   ├── app2
│   └── app3
├── bootstrap
│   ├── argo-cd
│   └── cluster-resources
└── projects
    ├── project1 
    └── project2
```

The apps directory will house all argocd applications, and the the projects directory will house all argocd projects. Projects provide a way to logically group applications and easily control things such as defaults and restrictions.

## Deploying an Application

To deploy a new application, place the appropiate ArgoCD [application CRD mainifest](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#applications) into the /bootstrap/template directory and allow for ArgoCD to [auto sync](https://argoproj.github.io/argo-cd/user-guide/auto_sync/) & deploy the application.

Conversely, to remove an application you must delete the corresponding app definition mainifest from the /bootstrap/template directory delete the application from the Argo UI, and allow for ArgoCD to sync again.

## Configuration Management

Each application can be configured based off a values.yaml [info](https://helm.sh/docs/chart_template_guide/values_files/). The bootstrap will expose the following pass through variables, for use in application configurations, as well.

## Secrets

Secrets will be stored in [vault](https://vault.internal-lab.com/ui/vault/secrets/k8s/list).  They will be organized by namespace.  In general secrets would be stored in `<namespace>/secrets`.  They will be made available to the pods via a [mutating webhook](https://banzaicloud.com/docs/bank-vaults/mutating-webhook/).  Using [annotations](https://banzaicloud.com/docs/bank-vaults/mutating-webhook/#common-annotations) and environment variables.

## Makefile Usage

To use the [Makefile](https://https://github.com/zacharyrgonzales-portfolio/kubernetes-base/Makefile) locally please install the following.

* [kubernetes install info][kubernetes]
* [kubeval install info][kubeval]
* [helm install info][helm]

[kubernetes]: https://kubernetes.io/docs/tasks/tools/install-kubectl/
[kubeval]: https://kubeval.instrumenta.dev/installation/
[helm]: https://helm.sh/docs/intro/install/

```bash
Kubernetes Base:
Usage: make [target]

create-argocd-app              use argoc-autopilot to generate a new app
create-argocd-project          use argoc-autopilot to generate a new project
check-argocd-auth-token        check for argocd auth token env variable
```
