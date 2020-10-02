#!/bin/bash
if ! tenant=$(az account show --query tenantId -o tsv); then
    tenant=$(az login --query tenantId -o tsv)
fi
echo "Tenant $tenant"
getazurecert $@