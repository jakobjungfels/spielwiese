# spielwiese

The following steps need to be done manually. The rest of the deployment is handled via GitHub actions and ArgoCD

## GitHub setup

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

Generate key

```shell
ssh-keygen -t ed25519 -C "spielwiese"
```

Add public part of the the generated key as deployment key in Github

![image](docs/deployment_key.png)

## Azure setup

Create terraform state storage

```shell
cd spielwiese\globalstatestorage
terraform init
terraform plan
terraform apply -auto-approve
```
