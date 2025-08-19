#!/bin/bash

# Script to update an EKS Cluster version and related add-ons
# Author: Harsha
# Usage: ./update-eks.sh <cluster_name> <region> <new_version>

set -euo pipefail

CLUSTER_NAME=my-cluster
REGION=us-east-1
NEW_VERSION=1.33

echo "🔹 Updating EKS Cluster: $CLUSTER_NAME in $REGION to version $NEW_VERSION"

# Step 1: Update EKS control plane
aws eks update-cluster-version \
  --region "$REGION" \
  --name "$CLUSTER_NAME" \
  --kubernetes-version "$NEW_VERSION"

echo "✅ Control plane update initiated. Waiting for completion..."

aws eks wait cluster-active \
  --region "$REGION" \
  --name "$CLUSTER_NAME"

echo "🎉 Control plane successfully updated to version $NEW_VERSION"

# Step 2: Update managed node groups
NODEGROUPS=$(aws eks list-nodegroups --cluster-name "$CLUSTER_NAME" --region "$REGION" --query 'nodegroups[*]' --output text)

for ng in $NODEGROUPS; do
  echo "🔹 Updating node group: $ng"
  aws eks update-nodegroup-version \
    --region "$REGION" \
    --cluster-name "$CLUSTER_NAME" \
    --nodegroup-name "$ng" \
    --kubernetes-version "$NEW_VERSION" \
    --scaling-config minSize=1,maxSize=3,desiredSize=2

  aws eks wait nodegroup-active \
    --region "$REGION" \
    --cluster-name "$CLUSTER_NAME" \
    --nodegroup-name "$ng"
  echo "✅ Node group $ng updated"
done

# Step 3: Update core add-ons (recommended)
for addon in vpc-cni kube-proxy coredns; do
  echo "🔹 Updating addon: $addon"
  aws eks update-addon \
    --cluster-name "$CLUSTER_NAME" \
    --region "$REGION" \
    --addon-name "$addon" \
    --resolve-conflicts OVERWRITE \
    || echo "⚠️ Addon $addon not found or already updated"
done

echo "🎯 EKS cluster upgrade completed successfully!"
