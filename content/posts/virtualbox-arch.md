---
categories:
- setup
- workflowdate: "2021-05-18"
date: "2021-06-11"
summary: "Saiba como instalar o Virtualbox no Arch Linux"
description: "Instalação do Virtualbox no Arch"
slug: instalar-virtualbox-arch
tags:
- arch
- setup
- virtualbox

title: Instalação do Virtualbox no Arch
---

## Instalação dos pacotes

{{< highlight bash >}}
sudo pacman -S virtualbox virtualbox-host-modules-arch
{{< / highlight >}}

Ao iniciar uma VM, caso ocorra o erro `kernel driver not installed (rc=-1908)` é preciso fazer o seguinte:

Antes de prosseguir é preciso saber qual a versão do sistema, para isso:
{{< highlight bash >}}
uname -r
{{< / highlight >}}

A resposta desse comando será parecido com isso: `5.10.41-1-MANJARO`. Sabendo a versão do sistema é preciso instalar alguns módulos adicionais.
{{< highlight bash >}}
sudo pacman -S linux510-virtualbox-host-modules # 5.10 -> 510, 4.19 -> 419
{{< / highlight >}}

E para finalizar ...
{{< highlight bash >}}
sudo mobprobe vboxdrv
{{< / highlight >}}

## Referências:
- [Virtualbox no Arch Linux](https://wiki.archlinux.org/title/VirtualBox_(Portugu%C3%AAs))
- [Como resolver rc=-1908](https://www.youtube.com/watch?v=sWoet7O0GsY)
