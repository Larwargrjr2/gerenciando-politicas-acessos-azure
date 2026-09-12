#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-policy-az900}"
SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
SCOPE="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RG"

echo "ATENÇÃO: este procedimento remove o Resource Group do laboratório."
read -r -p "Digite DELETE para confirmar: " CONFIRM

if [[ "$CONFIRM" != "DELETE" ]]; then
  echo "Operação cancelada."
  exit 0
fi

ASSIGNMENTS="$(az policy assignment list --scope "$SCOPE" --query "[].name" -o tsv 2>/dev/null || true)"
for ASSIGNMENT in $ASSIGNMENTS; do
  az policy assignment delete --name "$ASSIGNMENT" --scope "$SCOPE" || true
done

az group delete --name "$RG" --yes --no-wait

echo "Exclusão iniciada para $RG."
