DOTFILES = ${PWD}
CONFIGDIR = ${HOME}/.config
SLINKFLAG := -sf

setup-vim:
	ln $(SLINKFLAG) $(DOTFILES)/.vim ~
	ln $(SLINKFLAG) $(DOTFILES)/.vimrc ~
	vim +":PlugInstall | :qa"

setup-zsh:
	ln $(SLINKFLAG) $(DOTFILES)/.zsh ~
	ln $(SLINKFLAG) $(DOTFILES)/.zshrc ~

setup-tmux:
	ln $(SLINKFLAG) $(DOTFILES)/.tmux.conf ~

setup-tig:
	ln $(SLINKFLAG) $(DOTFILES)/.tigrc ~

make-configdir:
	if [ ! -d $(CONFIGDIR) ]; then mkdir $(CONFIGDIR); fi

setup-urxvt:
	ln $(SLINKFLAG) $(DOTFILES)/.urxvt $(CONFIGDIR)

setup-sway: make-configdir
	ln $(SLINKFLAG) $(DOTFILES)/.config/sway $(CONFIGDIR)
	ln $(SLINKFLAG) $(DOTFILES)/.config/waybar $(CONFIGDIR)

setup-cli: setup-zsh setup-tmux setup-tig setup-vim

setup-gui: setup-urxvt setup-sway

.PHONY: setup-vim setup-zsh setup-tmux setup-tig make-configdir setup-urxvt setup-sway setup-cli setup-gui

