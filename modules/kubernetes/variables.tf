variable "nodes" {
  description = "List of node IPs"
  type        = list(string)
}

variable "ssh_user" {
  description = "SSH user with sudo access"
  type        = string
}

variable "ssh_password" {
  description = "SSH password"
  type        = string
  sensitive   = true
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.26"
}