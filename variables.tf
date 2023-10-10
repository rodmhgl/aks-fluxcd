variable "suffix" {
  type        = string
  description = "Suffix to append for naming standard."
  default     = "gitops"
}

variable "location" {
  type        = string
  description = "Which region to create the AKS cluster in."
  default     = "westus3"
}

variable "gh_user" {
  type        = string
  description = "Github user name"
  default     = "rodmhgl"
}

variable "repo_name" {
  type        = string
  description = "Github repo name"
  default     = "aks-store-demo-manifests"
}

variable "repo_branch" {
  type        = string
  description = "Github deployment branch name"
  default     = "main"
}
