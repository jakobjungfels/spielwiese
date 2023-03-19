# spielwiese

## GitHub setup

Create service principle

```shell
az login
az account set --subscription <sub_id>
az ad sp create-for-rbac --name kubernetesPrincipal --role Contributor --scopes /subscriptions/<sub_id>
az ad sp list --display-name "kubernetesPrincipal" --query '[].{""Object ID"":objectId}' --output table
```

To login using the service principle

```shell
az login --service-principal -u <app_id> -p <principle_password> --tenant <tenant_id>
```

Create GitHub secrets for actions for Azure login

![image](docs/secrets.png)

## kubernetes cluster

Create terraform state storage

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
