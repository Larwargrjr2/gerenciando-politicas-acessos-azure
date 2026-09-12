#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-policy-az900}"
SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
SCOPE="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RG"

echo "== Policy Assignments no escopo =="
az policy assignment list --scope "$SCOPE" --output table

echo
echo "== Estado de conformidade =="
echo "A avaliação pode levar algum tempo após uma atribuição ou alteração."
az policy state summarize --resource-group "$RG" --output jsonc || {
  echo "A consulta de Policy State não está disponível para este contexto."
  echo "Use Azure Portal > Policy > Compliance."
  exit 0
}
