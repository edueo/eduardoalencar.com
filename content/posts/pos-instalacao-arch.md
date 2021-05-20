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

Recentemente iniciei em um novo emprego e depois de muito tempo trabalhando com MacOS, decidi voltar ao bom e velho Linux, como a muito tempo não fazia 
esse setup, resolvi documentar e foi bem divertido!


## Atualização do sistema

```
sudo pacman -Syu
```

## Pacotes essenciais

```
sudo pacman -S chromium awesome xorg-xrandr arandr picom nitrogen alacritty dmenu vim htop ncdu pulseaudio pavucontrol tree ranger fish spectacle obs-studio graphviz xclip code
```

Aqui instalo navegador, editores de texto, terminal, ferramentas de monitoramento de sistema e alguns "geri-geri" de interface gráfica.

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

*Para que essa mudança surta efeito é preciso efetuar log out* 

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

### ASDF

Na era dos (micros)serviços, é comum que um desenvolvedor atue em diferentes stacks de tecnologias. O [asdf](https://github.com/asdf-vm/asdf) é uma CLI (Command Line Interface) que permite
gerenciar multiplas linguagens em versões distintas.

**Para instalar**:

```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

```

Adicionar as linhas abaixo no arquivo de configuração do seu shell, no meu caso, como uso `bash`, adicionei no `.bashrc`

```
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
``` 

Após reiniciar o bash, já é possível usar a ferramenta.

Uma das características do asdf é ser extensível através de plugins, para listar todos os plugins disponíveis, execute:

```
asdf plugin list all
```

Vamos supor que precisamos instalar o `node` na versão `10.16.2`:

1. Precisamos saber qual o nome do plugin do node, para isso:

```
asdf plugin list all | grep node
```

2. Agora que sabemos o nome do plugin do node, podemos adicioná-lo ao asdf:

```
asdf plugin add nodejs
```

3. Para verificar se o plugin foi adicionado ao asdf, digitamos:
```
asdf plugin list
```

4. Com o plugin do node adicionado é possível verificar as versões disponíveis:

```
asdf list all nodejs
```

5. Para filtrar somente as versões `10.16` disponíveis, podemos usar o `grep`:

```
asdf list all nodejs | grep 10.16.*
```

6. Para instalar a versão escolhida, usamos:
```
asdf install nodejs 10.16.2
```

7. Podemos verificar as versões do node instaladas com o comando:

```
asdf list nodejs
```

8. Para usar a versão `10.16.2` globalmente, execute:

```
asdf global nodejs 10.16.2
```

9. Verifique a versão do node:
```
node --version # v10.16.2
```

## Nem tudo são flores

Alguns problemas que encontrei pós instalação foram: 

1. Ao reiniciar o sistema, as configurações dos monitores eram perdidas.

- Instalei o `arandr`, ferramenta gráfica que permite configurar os monitores.
- Efetuei a configuração desejada e salvei, isso gerou o seguinte arquivo:
```
#!/bin/sh
xrandr --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off
```
- Como uso o `awesome` (Vou dedicar um post especifico para falar desse cara), adicionei a seguinte na linha na sua configuração:

```
awful.spawn.with_shell("xrandr --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off")

```

2. Hora errada

- `sudo hwclock --systohc`
- alterei a ultima linha do arquivo `/etc/adjustime` de `UTC` para `LOCAL`

## Versionando minhas configurações

Meus arquivos de configurações, também conhecidos como `dotfiles`, podem ser vistas nesse [repositório](https://github.com/edueo/dot).


