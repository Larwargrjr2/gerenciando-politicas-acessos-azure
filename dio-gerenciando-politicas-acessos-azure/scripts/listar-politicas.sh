#!/usr/bin/env bash
set -euo pipefail

echo "== Assinatura atual =="
az account show --output table

echo
echo "== Algumas Policy Definitions integradas =="
az policy definition list --query "[?policyType=='BuiltIn'].{Nome:displayName,NomeInterno:name,Modo:mode}" --all --output table
