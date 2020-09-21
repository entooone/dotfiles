DOTFILES = ${PWD}
CONFIGDIR = ${HOME}/.config
SLINKFLAG := -sf
.DEFAULT_GOAL := setup-cli

.PHONY: goreturn
goreturn:
	if ! type goreturn &> /dev/null; then \
		GO111MODULE=off go get -u github.com/110y/goreturn; \
	fi

.PHONY: dlv
dlv:
	if ! type dlv &> /dev/null; then \
		GO111MODULE=off go get -u github.com/go-delve/delve/cmd/dlv; \
	fi

.PHONY: setup-vim-golang
setup-vim-golang: goreturn dlv

.PHONY: setup-vim
setup-vim: setup-vim-golang
	ln $(SLINKFLAG) $(DOTFILES)/.vim ~
	ln $(SLINKFLAG) $(DOTFILES)/.vimrc ~
	vim +PlugInstall +qall

.PHONY: setup-zsh
setup-zsh:
	ln $(SLINKFLAG) $(DOTFILES)/.zsh ~
	ln $(SLINKFLAG) $(DOTFILES)/.zshrc ~

.PHONY: setup-tmux
setup-tmux:
	ln $(SLINKFLAG) $(DOTFILES)/.tmux.conf ~

.PHONY: setup-tig
setup-tig:
	ln $(SLINKFLAG) $(DOTFILES)/.tigrc ~

.PHONY: .config
.config:
	if [ ! -d $(CONFIGDIR) ]; then mkdir $(CONFIGDIR); fi

.PHONY: setup-urxvt
setup-urxvt:
	ln $(SLINKFLAG) $(DOTFILES)/.urxvt $(CONFIGDIR)

.PHONY: setup-sway
setup-sway: .config
	ln $(SLINKFLAG) $(DOTFILES)/.config/sway $(CONFIGDIR)
	ln $(SLINKFLAG) $(DOTFILES)/.config/waybar $(CONFIGDIR)

.PHONY: setup-cli
setup-cli: setup-zsh setup-tmux setup-tig setup-vim

.PHONY: setup-gui
setup-gui: setup-urxvt setup-sway

