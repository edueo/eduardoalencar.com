---
categories:
- nginx
- servidores
date: "2020-10-27"
summary: "Hospedar um site estático com NGINX em um servidor com Ubuntu 20.04"
description: Como instalar o nginx 
slug: hospedar-sites-estaticos-com-nginx-no-ubuntu2004
tags:
- nginx
- ubuntu2004
- ssl
- ssh
- certbot
title: Hospedar um site estático no Ubuntu 20.04 com NGINX
---
## Atualização e instalação de pacotes

{{< highlight bash >}}
apt get update
apt install nginx certbot python3-certbot-nginx
{{< / highlight >}}

## Configuração do NGINX
Os arquivos de configuração do nginx ficam no diretório: `/etc/nginx`, para facilitar nosso trabalho, podemos copiar o arquivo de configuração do site `default` e alterar conforme nossa necessidade

{{< highlight bash >}}
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/meu-site
{{< / highlight >}}

Abra o arquivo `/etc/nginx/sites-available/meu-site` e insira o seguinte conteúdo:

{{< highlight text "linenos=table,hl_lines=4 8" >}}
server {
  listen 80 ;
  listen [::]:80 ;
  root /var/www/meusite;

  index.html index.htm index.nginx-debian.html;   

  server_name site.com www.site.com
  location / {
      try_files $uri $uri/ = 404;
    }
}
{{< / highlight >}}

## Ativando o seu site:

{{< highlight bash >}}
ln -s /etc/nginx/sites-available/cabin /etc/nginx/sites-enabled /etc/nginx/sites-enabled/
{{< / highlight >}}

## Site exemplo

{{< highlight bash >}}
mkdir -p /var/www/meusite
echo "Meu site" > /var/www/meusite/index.html
{{< / highlight >}}

## HTTPS com certbox

{{< highlight bash >}}
certbot --nginx
{{< / highlight >}}

Por padrão a validade do certificado gerado pela Lets Encrypt's é de 3 meses, para evitar a expiração do nosso certificado, vamos configurar a atualização automática usando `crontab`

{{< highlight bash >}}
crontab -e
{{< / highlight >}}

Inserir a linha:
{{< highlight bash >}}
1 1 1 * * certbot renew
{{< / highlight >}}




