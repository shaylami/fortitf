# Recovery Steps Broken Installation 

 1. Destroy the Partially Created Resources
 terraform destroy -auto-approve

 2. Manually Clean Up Kubernetes Setup
 incase kubeadm initialization failed, reset the cluster
 sudo kubeadm reset -f

 3. Reinstall Dependencies
 Validate that all required dependencies (kubeadm, kubelet, kubectl)
 sudo apt update && sudo apt install -y kubelet kubeadm kubectl

 4. Retry Terraform Deployment
 terraform apply -auto-approve

 Module Sepration
can assist in shared TF Projects to create resources without write them over again 
its more effctive and effort timeless jusr call the diraction of the module structuer
also can be done for recrated spesfic resource/acation in the same project again and agin 

