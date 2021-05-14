## Requisitos

![Hugo](hugo.jpg)

## Instalação Hugo

### MacOS

`brew install hugo`

### Linux

1. Acessar https://github.com/gohugoio/hugo/releases
2. Fazer download da úlima release para `Linux-64bit.tar.gz`
3. Descompactar
4. `sudo mv hugo /usr/local/bin`

Para testar a instalação, basta digitar `hugo` na raiz do projeto

## Executar o site localmente

1. Clonar esse repositório
```
git clone git@github.com:edueo/eduardoalencar.com.git
```

2. Executar o comando
```
make dev
```

3. Voilá
http://localhost:1313

## Deploy

```
make deploy
```
