# getazurecert
Tool to download certificates form azure keyvault to a linux machine

## How to use

First create a service principal for your computer with access to your keyvault:
```
> $keyvaultname="my-certificate-keyvault"
> az login
> $tenantId=(az account show --query tenantId -o tsv)
> $appId=(az ad sp create-for-rbac --name my-computer-name --create-cert --query appId -o tsv)
{
  "appId": "346627ff-79a5-4c18-a75c-d5cdc40719bb",
  "displayName": "my-computer-name",
  "fileWithCertAndPrivateKey": "C:\\Users\\Administrator\\tmpv_m18ce7.pem",
  "name": "http://my-computer-name",
  "password": null,
  "tenant": "ffdd504c-29c5-4928-861e-ccd76b1929ea"
}
> $objectId=(az ad sp show --id $appId --query objectId -o tsv)
> az keyvault set-policy --name $keyvaultname --object-id $objectId --secret-permission get --certificate-permission get
> az login --service-principal -u http://my-computer-name -p ~\tmpv_mm5tf0.pem --tenant $tenantId
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
