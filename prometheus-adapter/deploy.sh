#!/usr/bin/env bash

kubectl create namespace custom-metrics
kubectl apply -f custom-metrics-apiserver-auth-delegator-cluster-role-binding.yaml
kubectl apply -f custom-metrics-apiserver-auth-reader-role-binding.yaml
kubectl apply -f cm-adapter-serving-certs.yaml
kubectl apply -f custom-metrics-apiserver-deployment.yaml
kubectl apply -f custom-metrics-apiserver-resource-reader-cluster-role-binding.yaml
kubectl apply -f custom-metrics-apiserver-service-account.yaml
kubectl apply -f custom-metrics-apiserver-service.yaml
kubectl apply -f custom-metrics-apiservice.yaml
kubectl apply -f custom-metrics-cluster-role.yaml
kubectl apply -f custom-metrics-resource-reader-cluster-role.yaml
kubectl apply -f hpa-custom-metrics-cluster-role-binding.yaml