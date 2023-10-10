# Creation of full README pending

## Quick overview

Quick and dirty Terraform MVP to deploy a public AKS cluster that utilizes FluxCD and a GitOps methodology to deploy a simple application.

## Prerequisites

### Software

The majority of the below pre-requisites can be installed via the `scripts/install-prereqs.sh` script.
- AZ CLI
- kubectl
- kubelogin
- kustomize
- flux
- github cli

### Repositories

- Fork and clone this repository - [https://github.com/pauldotyu/aks-store-demo-manifests.git](https://github.com/pauldotyu/aks-store-demo-manifests.git)

```bash
cd aks-store-demo-manifests

mkdir base
mv *.yaml base

# change into the base directory
cd base

# Create base kustomization.yaml file
kustomize create --autodetect

# view the kustomization.yaml file
cat kustomization.yaml

# navigate back to the root of the repo
cd ../
mkdir -p overlays/dev
cd overlays/dev

# Create store-dev namespace in dev overlay
kubectl create namespace store-dev --dry-run=client -o yaml > namespace.yaml
# Create dev kustomization.yaml file
kustomize create --resources namespace.yaml,./../../base --namespace store-dev

## Note: I found it necessary to remove the liveness probes from store-admin and store-front yaml files
## If your store-admin or store-front pods are caught in a crash cycle, this is the likely cause

# view the kustomization.yaml file
cat kustomization.yaml

# Note how the dev namespace is appended when the manifests are generated
kustomize build

# make sure we are back at the root of the repo
cd ../../

# add all changes
git add .

# commit changes
git commit -m 'refactor: add kustomize base and dev overlay'

# push changes
git push
```

The repository should now be setup for FluxCD / Terraform to consume.

## Resources

- [Git going with GitOps on AKS: A Step-by-Step Guide using FluxCD AKS Extension](https://dev.to/azure/git-going-with-gitops-on-aks-a-step-by-step-guide-using-fluxcd-aks-extension-499m)
- [Tutorial: Deploy applications using GitOps with Flux v2](https://learn.microsoft.com/en-us/azure/azure-arc/kubernetes/tutorial-use-gitops-flux2?tabs=azure-cli)
- [Bootstrap your GitOps-enabled AKS cluster with Terraform: A code sample using the Flux v2 K8s Extension](https://dev.to/azure/bootstrap-your-gitops-enabled-aks-cluster-with-terraform-a-code-sample-using-the-flux-v2-k8s-extension-1l6d)
- [Flux V2 and Microsoft AKS](https://medium.com/@anoop.srivastava/flux-v2-and-microsoft-aks-7425e098a265)
