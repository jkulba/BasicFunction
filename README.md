# BasicFunction

Terraform provisioning for an Azure Function App.

## Manually Create the tfstate blob container

> [!IMPORTANT]  
> Prerequisites: Azure CLI, Terraform CLI, Azure Cloud Account

## Get started commands

(1) Checkout this repo

(2) Login to your Azure account

```shell
az login
```

(2) Navigate to the terraform folder and run init

```shell
terraform init -upgrade
```

_* the upgrade flag updates the version of the providers._

(3) Execute plan

```shell
terraform plan -out main.tfplan
```

(4) Execute apply

```shell
terraform apply
```

_Maintain the Terraform state in Azure Storage.  The follows steps create a dedicated resource group and a storage account to store the Terraform state._

## Create a resource group

```shell
az group create --name rg-npd-tfstate --location westus
```

## Create a storage account

```shell
az storage account create --name stnpdtfstatex --resource-group rg-npd-tfstate --location westus --sku Standard_LRS --allow-blob-public-access false --encryption-services blob
```

## Query for the storage account key

_The following command initializes the environment variable ACCOUNT_KEY.  This variable will be used in the next command._

```shell
$ACCOUNT_KEY=$(az storage account keys list --resource-group rg-npd-tfstate --account-name stnpdtfstatex --query '[0].value' -o tsv)
```

## Create container to store the Terraform state

```shell
az storage container create --account-name stnpdtfstatex --name tfstate --public-access off --account-key $ACCOUNT_KEY
```

