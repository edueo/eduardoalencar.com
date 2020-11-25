---
categories:
- lp
- kotlin
- jvm
date: "2020-11-25"
summary: "Hello Kotlin"
description: "Primeiros passos com Kotlin"
slug: hello-kotlin
tags:
- kotlin
- lp
- jvm

title: Hello Kotlin
---

## Compilador `kotlinc-jvm`

1. Fazer o download da release na página: 
https://github.com/JetBrains/kotlin/releases/tag/v1.4.20

2. Extrair o `.zip` para uma pasta de sua preferência.

3. Adicionar a pasta no `PATH` do sistema (isso funciona para MacOs e Linux)
Adicione a seguinte linha em seu `.bash_profile`
```
export PATH="$HOME/kotlinc/bin:$PATH" 
```
**No Fish** ...
```
set PATH $PATH $HOME/kotlinc/bin/
```

4. Reinicie seu terminal ou execute `source ~/.bash_profile`

5. Teste a instalação: `kotlinc-jvm`

6. `println("Hello Kotlin!!")`

## Links 
- https://kotlinlang.org/docs/tutorials/command-line.html

