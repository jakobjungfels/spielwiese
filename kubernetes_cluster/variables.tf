variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "./id_rsa.pub"
}

variable "dns_prefix" {
  default = "swk8sazure"
}

variable "cluster_name" {
  default = "sw-azure-kubernetes-cluster"
}

variable "vm_size" {
  default = "Standard_A2_v2"
}

variable "resource_group_name" {
  default = "kubernetes"
}

variable "location" {
  default = "westeurope"
}

variable "log_analytics_workspace_name" {
  default = "swLogAnalyticsWorkspace"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable "log_analytics_workspace_location" {
  default = "westeurope"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "aks_service_principal_app_id" {
  default = "1959b78b-9365-4f7d-96e3-24dec566d58e"
}

variable "aks_service_principal_client_secret" {
  default = "IttU_2XZSyIzuaoO-o.mINBfTq0MiMvsFq"
}

variable "aks_service_principal_object_id" {
  default = "a7759714-ed9d-4fed-8536-143508d28ce9"
}