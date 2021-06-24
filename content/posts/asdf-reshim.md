---
categories:
- go
- nodejs
- asdf
- reshim

date: "2021-06-15"
summary: "como resolver command not found no asdf"
description: "asdf e command not found"
slug: asdf-reshim
tags:
- go
- asdf

title: asdf reshim
---

Venho usando o asdf como gerenciador universal de linguagens de programação, como explico [nesse post](https://eduardoalencar.com/posts/o-que-vem-depois-da-instalacao-do-arch-linux/). Ao instalar pacotes de forma global
seja no nodejs com `npm i -g <pacote>` ou no go com `go get`, sempre me retornava: `command not found` ao tentar executá-los.
Depois de algumas pesquisas, encontrei a solução rodando o comando:
{{< highlight bash >}}
asdf reshim golang
asdf reshim nodejs
{{< / highlight >}}


