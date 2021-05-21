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

#### Fazendo meu editor entender a linguagem do Terraform

O Terraform usa uma linguagem específica (DSL) chamada hcl. Para o usuários do Visual Studio Code, 
aconselho instalar a extensão oficial: [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

#### Configurar seu provedor

O Terraform precisa saber qual o provedor (`Provider`) você deseja gerenciar, [aqui](https://registry.terraform.io/browse/providers) tem a lista dos provedores suportados.
Vou explicar como fazer o setup do provider da AWS.

1. Instalar [aws-cli](https://aws.amazon.com/pt/cli/)
2. Executar `aws configure` (Aqui você precisa informar o `aws_access_key_id` e `aws_secret_access_key` da conta que deseja gerenciar) 
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

4. Iniciar o projeto com `terraform init`

### Criando recursos

Para testar, podemos criar um recurso na AWS a nível de exemplo, para isso, vamos criar um bucket no S3. Para isso, 
adicione as linhas em seu `qualquercoisa.tf`:

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

- Executar `terraform fmt` para corrigir quaisquer problemas de formatação em seus arquivos `.tf`
- Verificar o que será alterado em sua infra, isso é feito com o comando: `terraform plan`
- Por fim é preciso aplicar as alterações com o comando: `terraform apply`

Para confirmar a criação do bucket, você pode acessar o console da AWS (alias agora ele só deve ter essa função: consultar recursos)



