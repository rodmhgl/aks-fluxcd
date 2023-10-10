#!/usr/bin/env bash

# Set Deployment Variables
# Replace AZ_SUB with your subscription ID or set it as an environment variable
# export AZ_SUB=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
GITOPS_RG_NAME=rg-gitops
GITOPS_AKS_NAME=aks-gitops
GITOPS_LOC_NAME=westus3
GITOPS_SUBSCRIPTION=$AZ_SUB
GITOPS_USERNAME=rodmhgl
gh_status=$(gh auth status 2>&1)