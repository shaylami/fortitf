resource "null_resource" "install_monitoring" {
  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.nodes[0]
  }

  provisioner "remote-exec" {
    inline = [
      "kubectl create namespace ${var.namespace} || true",
      "kubectl apply -f https://github.com/prometheus-operator/prometheus-operator/releases/latest/download/bundle.yaml -n ${var.namespace}",
      "kubectl apply -f https://raw.githubusercontent.com/grafana/helm-charts/main/charts/grafana/templates/deployment.yaml -n ${var.namespace}"
    ]
  }
}