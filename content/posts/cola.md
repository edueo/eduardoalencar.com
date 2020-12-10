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

## Configuração do postgres no Django.

{{< highlight bash >}}
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
