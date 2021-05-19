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

## Como ficaram meus arquivos de configurações (EXTRA)

### Git

```
git config --list --global
```

```
# This is Git's per-user configuration file.
[user]
	name = Eduardo Alencar de Oliveira
	email = ealencar10@gmail.com
# Please adapt and uncomment the following lines:
#	name = Eduardo Alencar de Oliveira
#	email = ealencar10@gmail.com
[push]
  followTags = true
[alias]
  c = !git add --all && git commit -m
  s = !git status -s
  l = !git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'
  amend = !git add --all && git commit --amend --no-edit
[core]
	editor = vim
```

### Bash 
```
#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls -la --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
# Personal alias
alias cw="nitrogen --set-zoom-fill --random ~/.wallpapers/backgrounds"
alias t="todo.sh"
alias clip="xclip -selection clipboard <"
alias awesome:edit="vim ~/.config/awesome/rc.lua"
alias alacritty:edit="vim ~/.config/alacritty/alacritty.yml"

# Projetos
alias workon:escale:catalogo="cd ~/code/escale/catalogo"

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# ASDF https://asdf-vm.com/#/core-manage-asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export EDITOR=vim

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/eduardo/google-cloud-sdk/path.bash.inc' ]; then . '/home/eduardo/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/eduardo/google-cloud-sdk/completion.bash.inc' ]; then . '/home/eduardo/google-cloud-sdk/completion.bash.inc'; fi

```

### Awesome
```
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dmenu
    awful.key({ modkey },            "space",     function ()
    awful.util.spawn("dmenu_run") end,
              {description = "run dmenu", group = "edu"}),

    -- Chromium laucher
    awful.key({ modkey },            "b",     function ()
    awful.util.spawn("chromium") end,
              {description = "run chromium", group = "edu"}),
    
    -- Spectacle print screen tool
    awful.key({ modkey },            "i",     function ()
    awful.util.spawn("spectacle") end,
              {description = "run spectacle", group = "edu"}),



    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,  }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
    -- c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--
-- Groselhas
--
beautiful.useless_gap = 3

-- Autostart
--
awful.spawn.with_shell("nitrogen --set-zoom-fill --random ~/.wallpapers/backgrounds")
awful.spawn.with_shell("xrandr --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off")
```

### Alacritty
```

#Configuration for Alacritty, the GPU enhanced terminal emulator.

# Any items in the `env` entry below will be added as
# environment variables. Some entries may override variables
# set by alacritty itself.
env:
  # TERM variable
  #
  # This value is used to set the `$TERM` environment variable for
  # each instance of Alacritty. If it is not present, alacritty will
  # check the local terminfo database and use `alacritty` if it is
  # available, otherwise `xterm-256color` is used.
  TERM: xterm-256color

window:
  # Window dimensions (changes require restart)
  #
  # Specified in number of columns/lines, not pixels.
  # If both are `0`, this setting is ignored.
  #dimensions:
  #  columns: 0
  #  lines: 0

  # Window position (changes require restart)
  #
  # Specified in number of pixels.
  # If the position is not set, the window manager will handle the placement.
  #position:
  #  x: 0
  #  y: 0

  # Window padding (changes require restart)
  #
  # Blank space added around the window in pixels. This padding is scaled
  # by DPI and the specified value is always added at both opposing sides.
  padding:
    x: 6
    y: 6

  # Spread additional padding evenly around the terminal content.
  dynamic_padding: false

  # Window decorations
  #
  # Values for `decorations`:
  #     - full: Borders and title bar
  #     - none: Neither borders nor title bar
  #
  # Values for `decorations` (macOS only):
  #     - transparent: Title bar, transparent background and title bar buttons
  #     - buttonless: Title bar, transparent background, but no title bar buttons
  #decorations: full

  # Startup Mode (changes require restart)
  #
  # Values for `startup_mode`:
  #   - Windowed
  #   - Maximized
  #   - Fullscreen
  #
  # Values for `startup_mode` (macOS only):
  #   - SimpleFullscreen
  #startup_mode: Windowed

  # Window title
  title: Alacritty

  # Window class (Linux/BSD only):
  class:
    # Application instance name
    instance: Alacritty
    # General application class
    general: Alacritty

  # GTK theme variant (Linux/BSD only)
  #
  # Override the variant of the GTK theme. Commonly supported values are `dark` and `light`.
  # Set this to `None` to use the default theme variant.
  #gtk_theme_variant: None

scrolling:
  # Maximum number of lines in the scrollback buffer.
  # Specifying '0' will disable scrolling.
  history: 5000

  # Number of lines the viewport will move for every line scrolled when
  # scrollback is enabled (history > 0).
  #multiplier: 3

  # Scroll to the bottom when new text is written to the terminal.
  #auto_scroll: false

# Spaces per Tab (changes require restart)
#
# This setting defines the width of a tab in cells.
#
# Some applications, like Emacs, rely on knowing about the width of a tab.
# To prevent unexpected behavior in these applications, it's also required to
# change the `it` value in terminfo when altering this setting.
#tabspaces: 8

# Font configuration
font:
  # Normal (roman) font face
  normal:
    # Font family
    #
    # Default:
    #   - (macOS) Menlo
    #   - (Linux/BSD) monospace
    #   - (Windows) Consolas
    family: Source Code Pro
    # family: CodeNewRoman Nerd Font
    # family: RobotoMono Nerd Font
    # family: Hack
    # family: JetBrains Mono
    # family: UbuntuMono Nerd Font
    # family: Monofur Nerd Font
    # family: TerminessTTF Nerd Font
    # family: Mononoki Nerd Font

    # The `style` can be specified to pick a specific face.
    style: Regular

  # Bold font face
  bold:
    # Font family
    #
    # If the bold family is not specified, it will fall back to the
    # value specified for the normal font.
    family: Source Code Pro
    # family: CodeNewRoman Nerd Font
    # family: RobotoMono Nerd Font
    # family: Hack
    # family: JetBrains Mono
    # family: UbuntuMono Nerd Font
    # family: Monofur Nerd Font
    # family: TerminessTTF Nerd Font
    # family: Mononoki Nerd Font

    # The `style` can be specified to pick a specific face.
    style: Bold

  # Italic font face
  italic:
    # Font family
    #
    # If the italic family is not specified, it will fall back to the
    # value specified for the normal font.
    family: Source Code Pro
    # family: CodeNewRoman Nerd Font
    # family: RobotoMono Nerd Font
    # family: Hack
    # family: JetBrains Mono
    # family: UbuntuMono Nerd Font
    # family: Monofuritalic Nerd Font Mono
    # family: TerminessTTF Nerd Font
    # family: Mononoki Nerd Font

    # The `style` can be specified to pick a specific face.
    style: Italic

  # Bold italic font face
  bold_italic:
    # Font family
    #
    # If the bold italic family is not specified, it will fall back to the
    # value specified for the normal font.
    family: Source Code Pro
    # family: CodeNewRoman Nerd Font
    # family: RobotoMono Nerd Font
    # family: Hack
    # family: JetBrains Mono
    # family: UbuntuMono Nerd Font
    # family: Monofuritalic Nerd Font Mono
    # family: TerminessTTF Nerd Font
    # family: Mononoki Nerd Font

    # The `style` can be specified to pick a specific face.
    style: Bold Italic

  # Point size
  size: 12.0

  # Offset is the extra space around each character. `offset.y` can be thought of
  # as modifying the line spacing, and `offset.x` as modifying the letter spacing.
  offset:
    x: 0
    y: 1

  # Glyph offset determines the locations of the glyphs within their cells with
  # the default being at the bottom. Increasing `x` moves the glyph to the right,
  # increasing `y` moves the glyph upwards.
  #glyph_offset:
  #  x: 0
  #  y: 0

  # Thin stroke font rendering (macOS only)
  #
  # Thin strokes are suitable for retina displays, but for non-retina screens
  # it is recommended to set `use_thin_strokes` to `false`
  #
  # macOS >= 10.14.x:
  #
  # If the font quality on non-retina display looks bad then set
  # `use_thin_strokes` to `true` and enable font smoothing by running the
  # following command:
  #   `defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`
  #
  # This is a global setting and will require a log out or restart to take
  # effect.
  #use_thin_strokes: true

# If `true`, bold text is drawn using the bright color variants.
draw_bold_text_with_bright_colors: true

# Colors (Tomorrow Night Bright)
colors:
  # Default colors
  primary:
    background: '0x282c34'
    foreground: '0xbbc2cf'

    # Bright and dim foreground colors
    #
    # The dimmed foreground color is calculated automatically if it is not present.
    # If the bright foreground color is not set, or `draw_bold_text_with_bright_colors`
    # is `false`, the normal foreground color will be used.
    #dim_foreground: '0x9a9a9a'
    #bright_foreground: '0xffffff'

  # Cursor colors
  #
  # Colors which should be used to draw the terminal cursor. If these are unset,
  # the cursor color will be the inverse of the cell color.
  #cursor:
  #  text: '0x000000'
  #  cursor: '0xffffff'

  # Selection colors
  #
  # Colors which should be used to draw the selection area. If selection
  # background is unset, selection color will be the inverse of the cell colors.
  # If only text is unset the cell text color will remain the same.
  selection:
    text: '0xbbc2cf'

  # Normal colors
  normal:
    black:   '0x1c1f24'
    red:     '0xff6c6b'
    green:   '0x98be65'
    yellow:  '0xda8548'
    blue:    '0x51afef'
    magenta: '0xc678dd'
    cyan:    '0x5699af'
    white:   '0x202328'

  # Bright colors
  bright:
    black:   '0x5b6268'
    red:     '0xda8548'
    green:   '0x4db5bd'
    yellow:  '0xecbe7b'
    blue:    '0x3071db'   # This is 2257a0 in Doom Emacs but I lightened it.
    magenta: '0xa9a1e1'
    cyan:    '0x46d9ff'
    white:   '0xdfdfdf'

  # Dim colors
  #
  # If the dim colors are not set, they will be calculated automatically based
  # on the `normal` colors.
  #dim:
  #  black:   '0x000000'
  #  red:     '0x8c3336'
  #  green:   '0x7a8530'
  #  yellow:  '0x97822e'
  #  blue:    '0x506d8f'
  #  magenta: '0x80638e'
  #  cyan:    '0x497e7a'
  #  white:   '0x9a9a9a'

  # Indexed Colors
  #
  # The indexed colors include all colors from 16 to 256.
  # When these are not set, they're filled with sensible defaults.
  #
  # Example:
  #   `- { index: 16, color: '0xff00ff' }`
  #
  #indexed_colors: []

# Visual Bell
#
# Any time the BEL code is received, Alacritty "rings" the visual bell. Once
# rung, the terminal background will be set to white and transition back to the
# default background color. You can control the rate of this transition by
# setting the `duration` property (represented in milliseconds). You can also
# configure the transition function by setting the `animation` property.
#
# Values for `animation`:
#   - Ease
#   - EaseOut
#   - EaseOutSine
#   - EaseOutQuad
#   - EaseOutCubic
#   - EaseOutQuart
#   - EaseOutQuint
#   - EaseOutExpo
#   - EaseOutCirc
#   - Linear
#
# Specifying a `duration` of `0` will disable the visual bell.
#visual_bell:
#  animation: EaseOutExpo
#  duration: 0
#  color: '0xffffff'

# Background opacity
#
# Window opacity as a floating point number from `0.0` to `1.0`.
# The value `0.0` is completely transparent and `1.0` is opaque.
background_opacity: 1.0
# background_opacity: 0.80

#selection:
  #semantic_escape_chars: ",│`|:\"' ()[]{}<>\t"

  # When set to `true`, selected text will be copied to the primary clipboard.
  #save_to_clipboard: false

# Allow terminal applications to change Alacritty's window title.
#dynamic_title: true

#cursor:
  # Cursor style
  #
  # Values for `style`:
  #   - ▇ Block
  #   - _ Underline
  #   - | Beam
  #style: Block

  # If this is `true`, the cursor will be rendered as a hollow box when the
  # window is not focused.
  #unfocused_hollow: true

# Live config reload (changes require restart)
#live_config_reload: true

# Shell
#
# You can set `shell.program` to the path of your favorite shell, e.g. `/bin/fish`.
# Entries in `shell.args` are passed unmodified as arguments to the shell.
#
# Default:
#   - (macOS) /bin/bash --login
#   - (Linux/BSD) user login shell
#   - (Windows) powershell
#shell:
#  program: /bin/bash
#  args:
#    - --login

# Startup directory
#
# Directory the shell is started in. If this is unset, or `None`, the working
# directory of the parent process will be used.
#working_directory: None

# WinPTY backend (Windows only)
#
# Alacritty defaults to using the newer ConPTY backend if it is available,
# since it resolves a lot of bugs and is quite a bit faster. If it is not
# available, the the WinPTY backend will be used instead.
#
# Setting this option to `true` makes Alacritty use the legacy WinPTY backend,
# even if the ConPTY backend is available.
#winpty_backend: false

# Send ESC (\x1b) before characters when alt is pressed.
#alt_send_esc: true

#debug:
  # Display the time it takes to redraw each frame.
  #render_timer: false

  # Keep the log file after quitting Alacritty.
  #persistent_logging: false

  # Log level
  #
  # Values for `log_level`:
  #   - None
  #   - Error
  #   - Warn
  #   - Info
  #   - Debug
  #   - Trace
  #log_level: Warn

  # Print all received window events.
  #print_events: false

  # Record all characters and escape sequences as test data.
  #ref_test: false

#mouse:
  # Click settings
  #
  # The `double_click` and `triple_click` settings control the time
  # alacritty should wait for accepting multiple clicks as one double
  # or triple click.
  #double_click: { threshold: 300 }
  #triple_click: { threshold: 300 }

  # If this is `true`, the cursor is temporarily hidden when typing.
  #hide_when_typing: false

  #url:
    # URL launcher
    #
    # This program is executed when clicking on a text which is recognized as a URL.
    # The URL is always added to the command as the last parameter.
    #
    # When set to `None`, URL launching will be disabled completely.
    #
    # Default:
    #   - (macOS) open
    #   - (Linux/BSD) xdg-open
    #   - (Windows) explorer
    #launcher:
    #  program: xdg-open
    #  args: []

    # URL modifiers
    #
    # These are the modifiers that need to be held down for opening URLs when clicking
    # on them. The available modifiers are documented in the key binding section.
    #modifiers: None

# Mouse bindings
#
# Mouse bindings are specified as a list of objects, much like the key
# bindings further below.
#
# Each mouse binding will specify a:
#
# - `mouse`:
#
#   - Middle
#   - Left
#   - Right
#   - Numeric identifier such as `5`
#
# - `action` (see key bindings)
#
# And optionally:
#
# - `mods` (see key bindings)
#mouse_bindings:
#  - { mouse: Middle, action: PasteSelection }

# Key bindings
#
# Key bindings are specified as a list of objects. For example, this is the
# default paste binding:
#
# `- { key: V, mods: Control|Shift, action: Paste }`
#
# Each key binding will specify a:
#
# - `key`: Identifier of the key pressed
#
#    - A-Z
#    - F1-F24
#    - Key0-Key9
#
#    A full list with available key codes can be found here:
#    https://docs.rs/glutin/*/glutin/event/enum.VirtualKeyCode.html#variants
#
#    Instead of using the name of the keys, the `key` field also supports using
#    the scancode of the desired key. Scancodes have to be specified as a
#    decimal number. This command will allow you to display the hex scancodes
#    for certain keys:
#
#       `showkey --scancodes`.
#
# Then exactly one of:
#
# - `chars`: Send a byte sequence to the running application
#
#    The `chars` field writes the specified string to the terminal. This makes
#    it possible to pass escape sequences. To find escape codes for bindings
#    like `PageUp` (`"\x1b[5~"`), you can run the command `showkey -a` outside
#    of tmux. Note that applications use terminfo to map escape sequences back
#    to keys. It is therefore required to update the terminfo when changing an
#    escape sequence.
#
# - `action`: Execute a predefined action
#
#   - Copy
#   - Paste
#   - PasteSelection
#   - IncreaseFontSize
#   - DecreaseFontSize
#   - ResetFontSize
#   - ScrollPageUp
#   - ScrollPageDown
#   - ScrollLineUp
#   - ScrollLineDown
#   - ScrollToTop
#   - ScrollToBottom
#   - ClearHistory
#   - Hide
#   - Minimize
#   - Quit
#   - ToggleFullscreen
#   - SpawnNewInstance
#   - ClearLogNotice
#   - ReceiveChar
#   - None
#
#   (macOS only):
#   - ToggleSimpleFullscreen: Enters fullscreen without occupying another space
#
# - `command`: Fork and execute a specified command plus arguments
#
#    The `command` field must be a map containing a `program` string and an
#    `args` array of command line parameter strings. For example:
#       `{ program: "alacritty", args: ["-e", "vttest"] }`
#
# And optionally:
#
# - `mods`: Key modifiers to filter binding actions
#
#    - Command
#    - Control
#    - Option
#    - Super
#    - Shift
#    - Alt
#
#    Multiple `mods` can be combined using `|` like this:
#       `mods: Control|Shift`.
#    Whitespace and capitalization are relevant and must match the example.
#
# - `mode`: Indicate a binding for only specific terminal reported modes
#
#    This is mainly used to send applications the correct escape sequences
#    when in different modes.
#
#    - AppCursor
#    - AppKeypad
#    - Alt
#
#    A `~` operator can be used before a mode to apply the binding whenever
#    the mode is *not* active, e.g. `~Alt`.
#
# Bindings are always filled by default, but will be replaced when a new
# binding with the same triggers is defined. To unset a default binding, it can
# be mapped to the `ReceiveChar` action. Alternatively, you can use `None` for
# a no-op if you do not wish to receive input characters for that binding.
key_bindings:
    # (Windows, Linux, and BSD only)
  - { key: V,         mods: Control|Shift, action: Paste                       }
  - { key: C,         mods: Control|Shift, action: Copy                        }
  - { key: Insert,    mods: Shift,         action: PasteSelection              }
  - { key: Key0,      mods: Control,       action: ResetFontSize               }
  - { key: Equals,    mods: Control,       action: IncreaseFontSize            }
  - { key: Plus,      mods: Control,       action: IncreaseFontSize            }
  - { key: Minus,     mods: Control,       action: DecreaseFontSize            }
  - { key: Minus,     mods: Control,       action: DecreaseFontSize            }
  - { key: F11,       mods: None,          action: ToggleFullscreen            }
  - { key: Paste,     mods: None,          action: Paste                       }
  - { key: Copy,      mods: None,          action: Copy                        }
  - { key: L,         mods: Control,       action: ClearLogNotice              }
  - { key: L,         mods: Control,       chars: "\x0c"                       }
  - { key: PageUp,    mods: None,          action: ScrollPageUp,   mode: ~Alt  }
  - { key: PageDown,  mods: None,          action: ScrollPageDown, mode: ~Alt  }
  - { key: Home,      mods: Shift,         action: ScrollToTop,    mode: ~Alt  }
  - { key: End,       mods: Shift,         action: ScrollToBottom, mode: ~Alt  }
```

