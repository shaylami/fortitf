############ Main Terraform File (main.tf) ############

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}

variable "nodes" {
  description = "List of node IPs"
  type        = list(string)
  default     = ["10.0.0.1", "10.0.0.2", "10.0.0.3"]
}

variable "ssh_user" {
  description = "SSH user with sudo access"
  type        = string
  default     = "k8suser"
}

variable "ssh_password" {
  description = "SSH password"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Namespace for Prometheus and Grafana"
  type        = string
  default     = "monitoring"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.26"
}

module "kubernetes_cluster" {
  source       = "./modules/kubernetes"
  nodes        = var.nodes
  ssh_user     = var.ssh_user
  ssh_password = var.ssh_password
  k8s_version  = var.k8s_version
}

module "monitoring" {
  source     = "./modules/monitoring"
  ssh_user = var.ssh_user
  ssh_password = var.ssh_password
  nodes = var.nodes
  namespace  = var.namespace
}


output "kubeconfig" {
  description = "Kubeconfig file path"
  value       = module.kubernetes_cluster.kubeconfig
}
