DOTFILES = ${PWD}
CONFIGDIR = ${HOME}/.config
SLINKFLAG := -sf
.DEFAULT_GOAL := setup-cli

.PHONY: update-gotools
update-gotools:
	go install -v golang.org/x/tools/cmd/goimports@latest
	go install -v golang.org/x/tools/gopls@latest
	go install -v github.com/go-delve/delve/cmd/dlv@latest
	go install -v github.com/110y/goreturn@latest

.PHONY: setup-vim
setup-vim:
	ln $(SLINKFLAG) $(DOTFILES)/.vim ~
	ln $(SLINKFLAG) $(DOTFILES)/.vimrc ~
	vim +PlugInstall +qall

.PHONY: setup-zsh
setup-zsh:
	ln $(SLINKFLAG) $(DOTFILES)/.zsh ~
	ln $(SLINKFLAG) $(DOTFILES)/.zshrc ~

.PHONY: setup-bash
setup-bash:
	ln $(SLINKFLAG) $(DOTFILES)/.bashrc ~


.PHONY: setup-tmux
setup-tmux:
	ln $(SLINKFLAG) $(DOTFILES)/.tmux.conf ~

.PHONY: setup-tig
setup-tig:
	ln $(SLINKFLAG) $(DOTFILES)/.tigrc ~

.PHONY: .config
.config:
	if [ ! -d $(CONFIGDIR) ]; then mkdir $(CONFIGDIR); fi

.PHONY: setup-alacritty
setup-alacritty:
	ln $(SLINKFLAG) $(DOTFILES)/.config/alacritty $(CONFIGDIR)

.PHONY: setup-sway
setup-sway: .config
	ln $(SLINKFLAG) $(DOTFILES)/.config/sway $(CONFIGDIR)
	ln $(SLINKFLAG) $(DOTFILES)/.config/waybar $(CONFIGDIR)

.PHONY: setup-cli
setup-cli: setup-bash setup-zsh setup-tmux setup-tig setup-vim

.PHONY: setup-gui
setup-gui: setup-alacritty setup-sway

