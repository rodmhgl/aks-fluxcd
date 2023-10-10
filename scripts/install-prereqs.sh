
#region prereqs
# Install kubectl/kubelogin if needed
if command -v kubectl &> /dev/null && command -v kubelogin &> /dev/null; then
  echo "Both kubectl and kubelogin are already installed."
else
  echo "kubectl or kubelogin not found. Installing..."
  sudo az aks install-cli
fi

# Install flux if not found
if command -v flux &> /dev/null; then
  echo "flux is already installed."
else
  echo "flux not found. Installing..."
  curl -s https://fluxcd.io/install.sh | sudo bash
fi

# Install GH CLI if not found
if command -v gh &> /dev/null; then
  echo "GitHub CLI is already installed."
  gh --version
else
  echo "GitHub CLI not found. Installing..."
  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y \
  && gh --version
fi

# Install kustomize if not found
if command -v kustomize &> /dev/null; then
  echo "kustomize is already installed."
  kustomize version
else
  echo "kustomize not found. Installing..."
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
  sudo install ./kustomize /usr/local/bin
fi
#endregion
