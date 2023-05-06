# spielwiese

The following steps need to be done manually. The rest of the deployment is handled via GitHub actions and ArgoCD

## GitHub setup

### Generate key(s)

There is a key in kubernetes_cluster that can be used for both the Kubernetes cluster and the ArgoCD login. However, it is advised to generate your own keys

```shell
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

### Service principle for Terraform

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

Create GitHub secrets

![image](docs/secrets.png)

### Deployment key for ArgoCD

Add public part of a generated key as deployment key in Github

![image](docs/deployment_key.png)

The private part of the key will be used to log into ArgoCD

## Azure setup

Create terraform state storage

```shell
cd spielwiese\globalstatestorage
terraform init
terraform plan
terraform apply -auto-approve
```

## ArgoCD

ArgoCD will deploy all application yml files in the applications folder
