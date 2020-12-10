---
categories:
- django
date: "2020-12-10"
summary: "Deploy projetos Django"
description: "Como fazer deploy de projetos django no Ubuntu 18.04 LTS com Nginx e uWSGI"
slug: deploy-projetos-django
tags:
- django
- deploy

title: Deploy de projetos Django
---

## Preparando o ambiente

**Atualizando os pacotes do Ubuntu**

{{< highlight bash >}}
sudo apt get update && sudo apt get upgrade
{{< / highlight >}}

**Instalando o `python3-venv`**

{{< highlight bash >}}
sudo apt install python3-venv
{{< / highlight >}}

**Instalando pacotes de desenvolvimento do Python3**

{{< highlight bash >}}
sudo apt install python3.6-dev
{{< / highlight >}}

## Ambiente virtual

**Criar**
{{< highlight bash >}}
python3 -mvenv venv
{{< / highlight >}}

**Ativar**
{{< highlight bash >}}
source venv/bin/activate
{{< / highlight >}}

