---
categories:
- git

date: "2021-06-25"
summary: "Comandos git do dia-a-dia"
description: "Se esquecer é só consultar"
slug: git-das-trincheiras
tags:
- git

title: git-das-trincheiras
---

- Criar uma tag
{{< highlight bash >}}
git tag -a '0.0.1' -m "Conteúdo da release"
{{< / highlight >}}

- Excluir uma tag do repositório remoto
{{< highlight bash >}}
git push --delete origin <nome-da-tag>
{{< / highlight >}}


