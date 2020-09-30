# getazurecert
Tool to download certificates form azure keyvault to a linux machine

## How to use

First create a service principal for your computer with access to your keyvault:
```
keyvaultname="my-certificate-keyvault"
az login
tenantId=$(az account show --query tenantId -o tsv)
app=$(az ad sp create-for-rbac --name my-computer-name --create-cert)
appId=$(echo $app | jq -r .appId)
certFile=$(echo $app | jq -r .fileWithCertAndPrivateKey)
objectId=$(az ad sp show --id $appId --query objectId -o tsv)
az keyvault set-policy --name $keyvaultname --object-id $objectId --secret-permission get --certificate-permission get
az login --service-principal -u http://my-computer-name -p $certFile --tenant $tenantId
```

Download script
```
wget https://raw.githubusercontent.com/herkit/getazurecert/master/src/getazurecert
chmod +x ./getazurecert
```

You are now ready to download certs:
```
./getazurecert --vault-name $keyvaultname --name my-certificate-name
```
