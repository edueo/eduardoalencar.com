---
categories:
- mongodb
- como-instalar

date: "2021-06-29"
summary: "Como instalar MongoDB Database Tools no Linux"
description: ""
slug: como-instalar-mongodb-database-tools-no-linux
tags:
- mongodb
- como-instalar

title: Como instalar o MongoDB Database Tools no Linux
---

O MongoDB Database Tools é um pacote com algumas ferramentas para administrar seu MongoDB. Para instalar no linux, siga os passos:

1. Faça o download do pacote no formato `tgz`, disponível nesse link: https://fastdl.mongodb.org/tools/db/mongodb-database-tools-amazon-x86_64-100.3.1.tgz

{{< highlight bash >}}
wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-amazon-x86_64-100.3.1.tgz
{{< / highlight >}}

2. Descompacte o arquivo

{{< highlight bash >}}
tar -zxvf mongodb-database-tools-*-100.3.1.tgz
{{< / highlight >}}

3. Entre no diretório dos binários

{{< highlight bash >}}
cd mongodb-database-tools-amazon-x86_64-100.3.1/bin 
{{< / highlight >}}

4. Deixe os binários disponíveis no `PATH`

{{< highlight bash >}}
sudo cp * /usr/local/bin/
{{< / highlight >}}

Para testar a instalação, execute:
{{< highlight bash >}}
mongoexport --version
{{< / highlight >}}

