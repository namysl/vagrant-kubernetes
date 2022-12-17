#!/bin/bash

install_minikube(){
  echo "Downloading and installing MINIKUBE"
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
  sudo dpkg -i minikube_latest_amd64.deb
  echo "MINIKUBE VERSION: $(minikube version)"
}

install_kubectl(){
  echo "Downloading and installing KUBECTL"
  curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  echo "KUBECTL VERSION: $(kubectl version --client --output=yaml)"
}

install_helm(){
  echo "Installing HELM"
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  echo "HELM VERSION: $(helm version)"
}

install_k6(){
  echo "Installing K6"
  sudo gpg -k
  sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
  echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
  sudo apt-get update
  sudo apt-get install k6
  echo "K6 VERSION: $(k6 version)"
}

install_minikube
install_kubectl
install_helm
install_k6
git clone https://github.com/namysl/vagrant-kubernetes-one-node.git
chown vagrant ./vagrant-kubernetes-one-node/after_config.sh
chmod u+x ./vagrant-kubernetes-one-node/after_config.sh
runuser -l vagrant -c './vagrant-kubernetes-one-node/after_config.sh'
