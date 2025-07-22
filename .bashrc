# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
source ~/dotfiles/aliases
export PATH="$PATH:$HOME/.local/bin"

#alias sqs="squeue -u mbfiamenghi -o \"%.12i %.10P %.18j %.10u %.2t %.8M %.6D %.6C %R\""
#alias mamba=micromamba
#alias conda=micromamba
#alias wormhole=wormhole-william
#alias cp=mcp
#alias clean_tmp="find /tmp -user mbfiamenghi ! -name 'tmux-*' -exec rm -rf {} \;"


export PATH="$HOME/.pixi/bin:$PATH"
eval "$(pixi completion --shell bash)"
tmux source ~/dotfiles/tmux.conf
