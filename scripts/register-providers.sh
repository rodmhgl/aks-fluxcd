#!/usr/bin/env bash

source ./set_variables.sh

#region Providers
# Register the AKS-ExtensionManager feature
# AKS-ExtensionManager is essential to fix error: "at least one of the claims 'puid' or 'altsecid' or 'oid' should be present"
# Thanks to https://medium.com/@anoop.srivastava/flux-v2-and-microsoft-aks-7425e098a265
az feature register --namespace Microsoft.ContainerService --name AKS-ExtensionManager --subscription $GITOPS_SUBSCRIPTION

while true; do
  if az feature list -o table | grep -qi registering; then
    echo "Features are still registering. Waiting..."
    sleep 10  # Wait for 10 seconds before checking again
  else
    echo "No features are registering. Proceeding..."
    break  # Exit the loop if no providers are in 'Registering' state
  fi
done

# Register the required resource providers
az provider register -n Microsoft.ContainerService --subscription $GITOPS_SUBSCRIPTION
az provider register --namespace Microsoft.Kubernetes --subscription $GITOPS_SUBSCRIPTION
az provider register --namespace Microsoft.KubernetesConfiguration --subscription $GITOPS_SUBSCRIPTION
az provider register --namespace Microsoft.ExtendedLocation --subscription $GITOPS_SUBSCRIPTION

# Monitor registration status (ETA: 10 minutes)
while true; do
  if az provider list -o table | grep -qi registering; then
    echo "Providers are still registering. Waiting..."
    sleep 10  # Wait for 10 seconds before checking again
  else
    echo "No providers are registering. Exiting..."
    break  # Exit the loop if no providers are in 'Registering' state
  fi
done
#endregion