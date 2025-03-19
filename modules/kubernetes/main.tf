resource "null_resource" "install_kubernetes" {
  count = length(var.nodes)

  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.nodes[count.index]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y apt-transport-https ca-certificates curl",
      "curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "echo \"deb https://apt.kubernetes.io/ kubernetes-xenial main\" | sudo tee /etc/apt/sources.list.d/kubernetes.list",
      "sudo apt update -y",
      "sudo apt install -y kubelet=${var.k8s_version}-00 kubeadm=${var.k8s_version}-00 kubectl=${var.k8s_version}-00",
      "sudo systemctl enable kubelet && sudo systemctl start kubelet",
      "sudo kubeadm init --pod-network-cidr=10.244.0.0/16 | tee /tmp/kubeadm-init.out"
    ]
  }
}
output "kubeconfig" {
  value = "/tmp/kubeconfig.yaml"
}