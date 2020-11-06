---
categories:
- ssh
- servidores
date: "2020-10-28"
summary: "2 dicas para deixar o acesso ssh mais seguro"
description: Deixando o ssh mais seguro
slug: 2-dicas-para-deixar-acesso-ssh-mais-seguro
tags:
- ssh
- ubuntu2004
title: 2 dicas para deixar seu ssh mais seguro
---

Esse post trás duas dicas para deixar o acesso via ssh mais seguro:

## Dica #1

Copiar sua chave pública para o servidor

{{< highlight bash >}}
ssh-copy-id ~/.ssh/id_rsa.pub user@ip-servidor
{{< / highlight >}}

O comando `ssh-copy-id` recebe o caminho da sua chave pública e o servidor destino, representados por 
`~/.ssh/id_rsa.pub` e `user@ip-servidor`, respectivamente no exemplo acima. Ao executar esse comando, será feito login via
ssh no servidor e sua chave será adicionada ao final do arquivo  `~/.ssh/authorized_keys`.

Isso vai permitir que na próxima vez que fizer login, não precisará digitar a senha.

## Dica #2

Impedir o acesso ssh via senha

Abrir o arquivo de configuração do `sshd`, localizado em `/etc/ssh/ssh_config` e adicionar as linhas abaixo:

{{< highlight text >}}
PasswordAuthentication no
UsePAM no
ChallengeResponseAuthentication no
{{< / highlight >}}

Após essa alteração é necessário reiniciar o serviço:

{{< highlight bash >}}
systemctl reload sshd
systemctl restart sshd
{{< / highlight >}}






