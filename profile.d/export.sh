export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export EDITOR=/usr/bin/vim
export SCREENDIR=$HOME/.screen
export TERM=xterm-256color
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/dotfiles/bin
export FZF_DEFAULT_COMMAND='find . | grep -v -E ".git"'
export FZF_DEFAULT_OPTS='--reverse --height 40%'

export PATH=$PATH:$HOME/.deno/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin

# java
#─────────────────────────────
export JAVA_HOME=/usr/lib/jvm/default
export JDK_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin
export JUNIT_HOME=/usr/share/java
export CLASSPATH=$JUNIT_HOME/junit.jar:$CLASSPATH

# aqua
#─────────────────────────────
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml
