# ==============================
# global zshrc
# ==============================
GLOBAL_ZSHRC="$HOME/.zsh/zshrc"
if [ -e $GLOBAL_ZSHRC ]; then
    source $GLOBAL_ZSHRC
fi

# ==============================
# local zshrc
# ==============================
LOCAL_ZSHRC="$HOME/.zsh/zshrc.local"
if [ -e $LOCAL_ZSHRC ]; then
    source $LOCAL_ZSHRC
fi

# ==============================
# Load Message
# ==============================
echo "~/.zshrc loaded"

