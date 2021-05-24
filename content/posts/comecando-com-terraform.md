---
categories:
- infra
- aprendendo

date: "2021-05-21"
summary: "Começando com Terraform"
description: "Iniciando minha jornada no IaC"
slug: comecando-com-terraform
tags:
- aws
- IaC
- gcp
- terraform
- azure
- ibm

title: Começando com Terraform
---
 
## O que é ?

>[Terraform](https://www.terraform.io/intro/index.html) é uma ferramenta para construir, mudar e versionar a infraestrutura de forma segura e eficiente.

## Instalação

O processo de instalação do Terraform está muito bem documentado [aqui](https://learn.hashicorp.com/tutorials/terraform/install-cli) 

Para verificar se a instalação foi realizada com sucesso, podemos usar o comando:

```
terraform version
```

### E agora por onde começo ?

#### HCL no Visual Studio Code (Opcional)

O Terraform possui uma linguagem específica (DSL) chamada [HCL](https://github.com/hashicorp/hcl). O Visual Studio Code tem uma [extensão oficial](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform) que adiciona o `syntax highlighting` para o HCL.

#### Configurar seu provedor

Provedor é onde o Terraform irá gerenciar sua infra, alguns exemplos: AWS, GCP, Azure e IBM Cloud,[aqui](https://registry.terraform.io/browse/providers) tem a lista dos provedores suportados.

##### Setup Provedor AWS

1. Instalar [aws-cli](https://aws.amazon.com/pt/cli/)
2. Executar `aws configure` (Aqui será preciso informar o `aws_access_key_id` e `aws_secret_access_key` da conta que deseja gerenciar) 
3. Criar um arquivo `qualquercoisa.tf` e adicionar o conteúdo:

```
terraform {
  required_providers {
      aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
            }
        }
}

# Configure the AWS Provider
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/home/eduardo/.aws/credentials"
  profile                 = "iaclab"
}

# Create a VPC
resource "aws_vpc" "vpc_iaclab" {
  cidr_block = "10.0.0.0/16"
}

```

`shared_credentials_file`: colocar o caminho das suas credenciais, por padrão é `$HOME/.aws/credentials`
`profile`: substituir pelo profile correto.

4. `terraform init`

#### Criando recursos

Para testar a configuração do Provider, vamos criar um bucket no S3. 

- Adicionar as linhas em seu arquivo `qualquercoisa.tf`
``` 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "b" {
  bucket = "meu-bucket-criado-com-tf"
  acl    = "private"

  tags = {
      Name        = "Meu bucket provisionado com Terraform"
      Environment = "Dev"
    }
}

```
- Executar `terraform fmt`
- Verificar o que será alterado em sua infra, isso é feito com o comando: `terraform plan`
- Por fim é preciso aplicar as alterações com o comando: `terraform apply`

Para confirmar a criação do bucket, você pode acessar o console da AWS (alias agora ele só deve ter essa função: consultar recursos)

#### Resumo dos principais comandos

`terraform init`: Cria arquivos iniciais, faz o download de módulos;  
`terraform fmt`: Corrige a formatação de arquivos `.tf`  
`terraform plan`: Mostra as mudanças que serão realizadas em sua infra;  
`terraform apply`: Aplica as mudanças em sua infra;

