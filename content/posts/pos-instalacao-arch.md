---
categories:
- setup
- workflow
date: "2021-05-18"
summary: "O que vem depois da instalação do Arch Linux?"
description: "Esse guia almeja explicar como ter um Arch Linux liso, pronto para desenvolvimento."
slug: o-que-vem-depois-da-instalacao-do-arch-linux
tags:
- arch
- setup
- workflow

title: O que vem depois da instalação do Arch Linux?
---

## Contexto

Recentemente iniciei em um novo emprego e depois de muito tempo trabalhando com Mac, resolvi voltar ao bom e velho Linux, como a muito tempo não fazia 
esse setup, resolvi documentar e foi bem divertido


## Atualização do sistema

```
sudo pacman -Syu
```

## Pacotes essenciais

```
sudo pacman -S chromium awesome xorg-xrandr arandr picom nitrogen alacritty dmenu vim htop ncdu pulseaudio pavucontrol tree ranger fish spectacle obs-studio graphviz xclip code
```

*****chromium**: Navegador
**awesome**: Gerenciador de janelas
**xorg-xrandr**: Resolução do monitor
**arandr**: Interface gráfica de configuração de monitores
**picom**:
**nitrogen**: Troca automática de wallpapers
**alacritty**: Terminal
**dmenu**: Barra de menu
**vim**: Editor 
**htop**: Monitoramento
**ncdu**: df com asteróids
**pulseaudio**: 
**pavucontrol**:
**tree**:
**ranger**:
**fish**:
**spectacle**:
**obs-studio**:
**graphviz**:
**xclip**:
**code**: Editor
TODO: Explicar cada um deles e colocar links na referências.


### Docker

Uma ferramenta essencial no dia-a-dia do programador é o docker, seja para rodar projetos localmente, ou para testar tecnologias de forma rápida.
Para instalar, abra o terminal e digite o comando:

```
sudo pacman -S docker
```

Depois de instalado, é necessário iniciar e habilitar o serviço: `docker.service` isso é feito através do `systemctl`:
```
sudo systemctl start docker.service
sudo systemctl enable docker.service
```

Por padrão, apenas o usuário root consegue executar comandos docker, para mudar esse comportamento é preciso adicionar
o seu usuário no grupo do docker.

```
sudo usermod -aG docker $USER
```

__Para que essa mudança surta efeito é preciso efetuar log out__ 

Para testar o funcionamento, abra o terminal e digite:

```
docker run -it --rm hello-world
```

A saída esperada desse comando é: 
```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```


### Zoom

### ASDF

## Configurações

### Git

### Bash

### Awesome

### Alacritty



## Links 

