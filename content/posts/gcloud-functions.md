---
categories:
- gcloud
- serverless
date: "2020-11-11"
summary: "Google Cloud Functions"
description: Alias para incrementar produtividade no git
slug: configuracao-git
tags:
- gcloud
- serverless
- gcp

title: Google Cloud Functions
---

# Google Cloud Functions

- [Instalação gcloud, gsutil e bq](https://cloud.google.com/sdk/docs/install)

## Inicialização gcloud
{{< highlight bash >}}
gcloud init
{{< / highlight >}}

## Projeto de exemplo


## Variáveis de ambiente

Devem ser especificadas em um arquivo, o nome do arquivo deve ser informado no parâmetro `--env-vars-file`, como mostrado no exemplo de deploy a seguir:

{{< highlight text >}}
FACEBOOK_APP_ID: "146546456445"
FACEBOOK_APP_SECRET: "daldjalskjdlkjsadla3554"
BIGQUERY_TABLE: "table_id"
{{< / highlight >}}

## Deploy
{{< highlight makefile >}}
deploy:
	gcloud functions deploy nome_da_funcao \
		--runtime python37 \
		--env-vars-file .env.yml \
		--timeout=540 \
		--trigger-http
{{< / highlight >}}




