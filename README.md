> This repo contains changes made during live stream. Source repo is [ondrejsika/devops-live-6](https://github.com/ondrejsika/devops-live-6).

[DevOps Live](https://devopslive.cz) | [Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# DevOps Live #6

## Training

- Kubernetes - https://ondrej-sika.cz/skoleni/kubernetes
- Terraform - https://ondrej-sika.cz/skoleni/terraform

## Related Repositories

- Setup of Kubernetes Cluster using Terraform - https://github.com/ondrejsika/terraform-do-kubernetes-example

## Quick start

Apply Terraform manifests

```
terraform init
terraform apply
```

Setup parking site

```
helm upgrade --install cf01 ondrejsika/one-image --set image=ondrejsika/parking --set host=cf01.eu
```
