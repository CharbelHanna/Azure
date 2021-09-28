az group create -name komo-aks-test-rg --location westeurope
az group create --name komoaksclt01-Resources-rg --location westeurope
az aks create --resource-group komo-aks-test-rg --name komoaksclt01 --node-count 1 --generate-ssh-keys --node-resouce-group
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster