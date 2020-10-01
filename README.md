# getazurecert
Tool to download SSL certificates form Azure KeyVault to a linux machine

## How to use

First, if you haven't done it already, create a service principal for your computer with access to your keyvault:
```
keyvaultname="my-certificate-keyvault"
serviceprincipalname=sp-$(hostname)
az login # log in with your user
tenantId=$(az account show --query tenantId -o tsv)
app=$(az ad sp create-for-rbac --name $serviceprincipalname --create-cert)
appId=$(echo $app | jq -r .appId)
certFile=$(echo $app | jq -r .fileWithCertAndPrivateKey)
objectId=$(az ad sp show --id $appId --query objectId -o tsv)
az keyvault set-policy --name $keyvaultname --object-id $objectId --secret-permission get --certificate-permission get
az login --service-principal -u http://$serviceprincipalname -p $certFile --tenant $tenantId
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

This will store the certificate in the current folder as my-certificate-name.crt and my-certificate-name.key.

You can specify filename to download to (and check for expiration) using the options --key-file and --cert-file like this:

```
./getazurecert --vault-name $keyvaultname --name my-certificate-name --key-file /etc/nginx/ssl/my-site.key --cert-file /etc/nginx/ssl/my-site.crt
```
