---
categories:
- cola
- django
date: "2020-12-10"
summary: "Cola"
description: "Colinha, aqui vou centralizar todos os snippets, comandos e tudo o que for útil para facilitar a vida de desenvolvedor"
slug: colinha
tags:
- cola
- django
- snippets

title: Colinha
---

## Django


**Configuração Postgres**

{{< highlight python >}}
# settings.py
[...]
DATABASES = {
    'default': {
          'ENGINE': 'django.db.backends.postgresql',
          'NAME': 'metrikfy2',
          'USER': 'eduardo.alencar',
          'PASSWORD': 'psql123',
          'HOST': 'localhost'
      }
}
[...]
{{< / highlight >}}

**Instalar pacote psycopg2 no MacOS Catalina**

Se o padrão `pip install psycopg2` não funcionar, usar:

{{< highlight bash >}}
env LDFLAGS='-L/usr/local/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib' pip install psycopg2==2.8.6
{{< / highlight >}}


