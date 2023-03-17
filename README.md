# spielwiese

## kubernetes cluster

```shell
az login
az account set --subscription <subid>
az ad sp create-for-rbac --name kubernetesPrincipal --role Contributor --scopes /subscriptions/<subid>
az ad sp list --display-name "kubernetesPrincipal" --query '[].{""Object ID"":objectId}' --output table
```

```shell
cd spielwiese\globalstatestorage
terraform init
terraform plan
terraform apply -auto-approve
```

```shell
cd spielwiese\kubernetes_cluster\cluster
terraform init
terraform plan
terraform apply -auto-approve
echo "$(terraform output kube_config)" > ./azurek8s
```

```shell
kubectl --kubeconfig=spielwiese\kubernetes_cluster\azurek8s create namespace argocd
kubectl --kubeconfig=spielwiese\kubernetes_cluster\azurek8s apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl --kubeconfig=spielwiese\kubernetes_cluster\azurek8s port-forward svc/argocd-server -n argocd 8080:443
kubectl --kubeconfig=spielwiese\kubernetes_cluster\azurek8s patch svc argocd-server -n argocd --patch-file spielwiese\argocd\patch_file.yaml
kubectl --kubeconfig=spielwiese\kubernetes_cluster\azurek8s get secret -n argocd argocd-initial-admin-secret -o yaml
```
