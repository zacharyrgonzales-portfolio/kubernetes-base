#!/bin/bash

# Destroy current cluser if present
kind delete cluster

# Create kind cluster using custom config
kind create cluster --config kind.config

# Get docker subnet
docker network inspect kind -f '{{(index .IPAM.Config 0).Subnet}}'

# Install cilium chart
helm upgrade --install --namespace kube-system --repo https://helm.cilium.io cilium cilium --values manifests/cilium-values.yaml

# Install metallb
helm upgrade --install --namespace metallb-system --create-namespace --repo https://metallb.github.io/metallb metallb metallb --values manifests/metallb-values.yaml

# Install nginx 
helm upgrade --install --namespace ingress-nginx --create-namespace --repo https://kubernetes.github.io/ingress-nginx ingress-nginx ingress-nginx --values manifests/nginx-values.yaml




