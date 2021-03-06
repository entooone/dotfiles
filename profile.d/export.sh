export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/chromium
export SCREENDIR=$HOME/.screen
export TERM=xterm-256color
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/dotfiles/bin
export FZF_DEFAULT_COMMAND='find . | grep -v -E ".git"'
export FZF_DEFAULT_OPTS='--preview "if [ -d {} ]; then ls -1F --color {}/; else cat {}; fi"'
if type bat &> /dev/null; then
    export FZF_DEFAULT_OPTS='--preview "if [ -d {} ]; then ls -1F --color {}/; else bat --style=numbers --color=always --line-range :500 {}; fi"'
fi

# deno
#─────────────────────────────
export PATH="/home/u5er/.deno/bin:$PATH"


# golang
#─────────────────────────────
if type "go" > /dev/null 2>&1; then
    export PATH=$PATH:$(go env GOPATH)/bin
fi


# java
#─────────────────────────────
export JAVA_HOME=/usr/lib/jvm/default
export JDK_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin
export JUNIT_HOME=/usr/share/java
export CLASSPATH=$JUNIT_HOME/junit.jar:$CLASSPATH
