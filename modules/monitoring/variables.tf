variable "namespace" {
  description = "Namespace for Prometheus and Grafana"
  type        = string
  default     = "monitoring"
}
variable "nodes" {
  description = "List of node IPs"
  type        = list(string)
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