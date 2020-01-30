# terraform-terragrunt-showcase

## requirements

Install Taskfile from [here](https://taskfile.dev/#/installation).

Install Terraform and Terragrunt as described [here](https://blog.gruntwork.io/how-to-manage-multiple-versions-of-terragrunt-and-terraform-as-a-team-in-your-iac-project-da5b59209f2d).
```
# TERRAFORM
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
sudo ln -s ~/.tfenv/bin/* /usr/local/bin
tfenv install 0.12.20

# TERRAGRUNT
git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv
sudo ln -s ~/.tgenv/bin/* /usr/local/bin
tgenv install 0.21.11
```

Install Kafka as a Terraform Provider manually, because it is not automatically installed
```
# TERRAFORM - KAFKA PROVIDER
TERRAFORM_KAFKA_PROVIDER_VERSION=0.2.3
wget https://github.com/Mongey/terraform-provider-kafka/releases/download/v"$TERRAFORM_KAFKA_PROVIDER_VERSION"/terraform-provider-kafka_"$TERRAFORM_KAFKA_PROVIDER_VERSION"_linux_amd64.tar.gz \
   && tar -xf terraform-provider-kafka_"$TERRAFORM_KAFKA_PROVIDER_VERSION"_linux_amd64.tar.gz \
   && mkdir --parents ~/.terraform.d/plugins \
   && mv terraform-provider-kafka_v"$TERRAFORM_KAFKA_PROVIDER_VERSION" ~/.terraform.d/plugins/
```
