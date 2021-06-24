---
categories:
- vagrant
- docker
- ubuntu

date: "2021-06-24"
summary: "Usando Vagrant para ter um ambiente de desenvolvimento com Ubuntu e Docker"
description: "Esse artigo detalha como ter um ambiente com Ubuntu e Docker instalados em uma VM, utilizando para isso o Vagrant"
slug: usando-vagrant-para-ter-uma-vm-com-ubuntu-docker
tags:
- vagrant
- docker
- ubuntu

title: Usando Vagrant para ter um ambiente de desenvolvimento com Ubuntu e Docker
---

## Pré-requisitos

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads)

## Glossário

- VM: Virtual Machines em bom português máquinas virtuais

## O que o Vagrant faz ?

Ele facilita o gerenciamento de VM's, com ele é possível criar, parar, excluir, acessar a vm por ssh, entre outras coisas.

Para verificar se o vagrant foi corretamente instalado, digite o comando abaixo em seu terminal:

{{< highlight bash >}}
vagrant --version
{{< / highlight >}}

O resultado esperado é algo como: `Vagrant 2.2.16`


## Vagrantfile

Esse é o arquivo que centraliza as configurações do Vagrant. Crie um arquivo chamado `Vagrantfile` em seu diretório e coloque o contéudo abaixo:

{{< highlight ruby "linenos=table,hl_lines=5 7 9 11" >}}
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  
  config.vm.hostname = "ubuntu-dev-machine"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provision "shell", path: "./provision-dev-vm.sh"
end

{{< / highlight >}}


Linha 5: Especifica o sistema operacional da VM, em nosso caso será instalado a versão 18.04 codenome `xenial`.

Linha 7: Determina o nome da VM `ubuntu-dev-machine`

Linha 9: Faz o redirecionamento da porta 3000 da VM para a 3000 da nossa máquina.

Linha 11: Especifica o caminho do nosso script de provisionamento

## Provisionando sua VM

No mesmo local onde colocamos o `Vagrantfile` precisamos colocar o arquivo `provision-dev-vm.sh`, com o conteúdo:

{{< highlight shell >}}
#
# Provision a development environment under Vagrant.
#

# https://serverfault.com/questions/227190/how-do-i-ask-apt-get-to-skip-any-interactive-post-install-configuration-steps
export DEBIAN_FRONTEND=noninteractive

#
# Install Docker.
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
#
sudo apt-get -yq update
sudo apt-get -yq install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -yq update
sudo apt-get -yq install docker-ce=5:19.03.12~3-0~ubuntu-xenial
docker --version

#
# User setup for docker.
#
sudo usermod -aG docker $USER
sudo service docker restart

{{< / highlight >}}

Esse script é executado quando nossa VM é inicializada, ele faz a atualização dos pacotes
do Ubuntu  e instalar o Docker.


## Testando

Nesse ponto já temos o que precisamos: o arquivo de configuração do Vagrant e o script
que fará a instalação do Docker em nossa VM. Para iniciar a máquina usamos o comando

{{< highlight bash >}}
vagrant up
{{< / highlight >}}

Esse processo vai levar alguns minutos, pois o Vagrant vai baixar o Ubuntu, fazer a configuração da VM e executar o script que atualiza o Ubuntu e faz a instalação
do docker. Ao terminar verifique se tudo está funcionando como esperado com o comando

{{< highlight bash >}}
vagrant status
{{< / highlight >}}



{{< highlight bash "linenos=table,hl_lines=3" >}}
Current machine states:

default                   running (virtualbox)

  The VM is running. To stop this VM, you can run `vagrant halt` to
  shut it down forcefully, or you can run `vagrant suspend` to simply
  suspend the virtual machine. In either case, to restart it again,
  simply run `vagrant up`.

{{< / highlight >}}

A linha destacada indica que nossa VM está em execução.

## Acessando a VM

{{< highlight bash >}}
vagrant ssh
{{< / highlight >}}

{{< highlight bash >}}
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

31 packages can be updated.
16 of these updates are security updates.
To see these additional updates run: apt list --upgradable

New release '18.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@ubuntu-dev-machine:~$

{{< / highlight >}}

## Usando docker dentro da VM

Ao acessar a VM podemos executar o comando

{{< highlight bash >}}
docker --version
{{< / highlight >}}

{{< highlight bash >}}
Docker version 20.10.7, build f0df350 
{{< / highlight >}}

## Resumo principais comandos do Vagrant

Inicia a VM

{{< highlight bash >}}
vagrant up
{{< / highlight >}}

Inicia a VM, forçando o provisionamento, ou seja, 
o script especificado em `config.vm.provision` será executado.

{{< highlight bash >}}
vagrant up --provision
{{< / highlight >}}

Acessa a VM via ssh
{{< highlight bash >}}
vagrant ssh
{{< / highlight >}}

Desliga a VM
{{< highlight bash >}}
vagrant suspend
{{< / highlight >}}

Remove a VM
{{< highlight bash >}}
vagrant destroy
{{< / highlight >}}

Todos os arquivos estão disponíveis em: https://github.com/edueo/ubuntu-dev-machine

