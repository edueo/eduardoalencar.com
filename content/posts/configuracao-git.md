---
categories:
- git
date: "2020-11-09"
summary: "Configuração git"
description: Alias para incrementar produtividade no git
slug: configuracao-git
tags:
- git
- alias
title: Alguns alias para facilitar o uso do git
---

## Configurações do git ?

Atráves do comando `git config`, precisamos especificar qual o nível de configuração que queremos modificar, as opções, são:
- global (`--global`)
- system (`--system`)
- local (`--local`)

### --global
  As configurações serão válidas para todos os projetos git do seu usuário.

### --system
  As configurações serão válidas para todos os projetos git de todos os usuários do sistema

### --local
  As configurações serão válidas apenas para determinado projeto git

### Para editar

{{< highlight bash >}}
git config --global --edit
{{< / highlight >}}

### Para listar
{{< highlight bash >}}
git config --global --list
{{< / highlight >}}

## Meus alias

{{< highlight text >}}
c = !git add --all && git commit -m
s = !git status -s
l = !git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'
amend = !git add --all && git commit --amend --no-edit
{{< / highlight >}}

### git c
  Atalho para adicionar e comitar todos os arquivos

### git s
  Status mais curto 

### git l
  Log em uma linha formato

### git amend
  Dá um amend no último commit sem editar mensagem
