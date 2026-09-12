#!/usr/bin/env bash
set -euo pipefail

RG="${RG:-rg-policy-az900}"
LOCATION="${LOCATION:-eastus}"
POLICY_NAME="${POLICY_NAME:-require-environment-tag}"
TAG_NAME="${TAG_NAME:-Environment}"

echo "== Laboratório de Azure Policy =="
echo "Resource Group: $RG"
echo "Location: $LOCATION"
echo "Policy: $POLICY_NAME"
echo "Tag: $TAG_NAME"
echo

az group create --name "$RG" --location "$LOCATION" --output table

POLICY_ID="$(az policy definition list   --query "[?displayName=='Require a tag on resources'].name | [0]"   -o tsv)"

if [[ -z "$POLICY_ID" ]]; then
  echo "ERRO: a Policy Definition integrada 'Require a tag on resources' não foi encontrada."
  echo "Use 'az policy definition list' para localizar uma definição equivalente na sua região/tenant."
  exit 1
fi

if az policy assignment show --name "$POLICY_NAME" --scope "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RG" >/dev/null 2>&1; then
  echo "Assignment já existe: $POLICY_NAME"
else
  az policy assignment create     --name "$POLICY_NAME"     --display-name "Lab AZ-900 - exigir tag Environment"     --policy "$POLICY_ID"     --scope "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RG"     --params "{\"tagName\":{\"value\":\"$TAG_NAME\"}}"     --output table
fi

echo
echo "Assignment criada/confirmada."
echo "Consulte Compliance no Azure Portal ou execute check-compliance.sh."
