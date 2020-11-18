[DevOps Live](https://devopslive.cz) | [Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# DevOps Live #6

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
