---
categories:
- go
- asdf
- dev-das-trincheiras

date: "2021-06-15"
summary: "asdf e go get"
description: "Usando pacotes go usando asdf"
slug: asdf-e-go-get
tags:
- go
- asdf

title: asdf e instalação de pacotes go 
---

Ultimamente venho brincando com GO e como mencionei [nesse post](https://eduardoalencar.com/posts/o-que-vem-depois-da-instalacao-do-arch-linux/) estou usando o __asdf__ para gerenciar multiplas
linguagens de programação. Nas minhas explorações no github, encontrei uma ferramenta bem legal, chamada [slides](https://github.com/maaslalani/slides), ela é escrita em GO e permite fazer apresentações no terminal a partir de um arquivo
Markdown e resolvi testá-la. Fiz a instalação da seguinte forma:

{{< highlight bash >}}
go install github.com/maaslalani/slides
{{< / highlight >}}

Mas ao executar o comando `slides`, ele não foi encontrado. Para fazer funcionar, foi preciso executar o comando:
{{< highlight bash >}}
asdf reshim golang
{{< / highlight >}}

