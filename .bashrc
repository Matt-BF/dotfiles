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
export PATH="$PATH:$HOME/.local/bin"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/clusterfs/jgi/groups/science/homes/mbfiamenghi/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/clusterfs/jgi/groups/science/homes/mbfiamenghi/.micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

alias sqs="squeue -u mbfiamenghi -o \"%.12i %.10P %.18j %.10u %.2t %.8M %.6D %.6C %R\""
alias mamba=micromamba
alias conda=micromamba
#alias wormhole=wormhole-william
#alias cp=mcp
alias fsdu="dust -DRrp -z 1G"
#alias clean_tmp="find /tmp -user mbfiamenghi ! -name 'tmux-*' -exec rm -rf {} \;"

dufolders () {
    find ./ -maxdepth 1 -type d -print0 | xargs -0 -n1 -P4 du -sh
}

tv () {
    first_line=$(head -n1 "$1")
    if [[ ! $first_line == *$'\t'* && $first_line == *,* ]]; then
	csvtk pretty $1 | less --header 1
    else
	csvtk -t pretty $1 | less --header 1
    fi
}


seqcnt() {
    if [[ $(file -bi --mime "$1") =~ "gzip" ]]; then
        if command -v pigz > /dev/null; then
            pigz -c -d "${@}" | rg -c "^>"
        else
            gzip -c -d "${@}" | rg -c "^>"
        fi
    else
        rg -c "^>" "${@}"
    fi
}

tsvtk() {
    csvtk $1 -t -T "${@:2}"
}

tar_compress() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: ${FUNCNAME[0]} <files> <tarball>"
        return 1
    fi
    local tarball="${!#}"
    local files="${@:1:$#-1}"
    if command -v pigz > /dev/null; then
        tar cf - $files | pigz -7 > $tarball
    else
        tar cf - $files | gzip -7 > $tarball
    fi
}

tar_extract() {
    if [ $# -ne 1 ]; then
        echo "Usage: ${FUNCNAME[0]} <compressed_file>"
        return 1
    fi
    compressed_file=$1
    filename="${compressed_file%.*}"
    if [ ! -f "$compressed_file" ]; then
        echo "Error: $compressed_file not found."
        return 1
    fi
    case "$compressed_file" in
        *.tar.gz)
            if command -v pigz >/dev/null; then
                tar -I pigz -xf "$compressed_file"
            else
                tar -xzf "$compressed_file"
            fi
        ;;
        *.tar.xz)
            tar -xJf "$compressed_file"
        ;;
        *.tar.bz2)
            tar -xjf "$compressed_file"
        ;;
        *.tar.zst)
            tar -I zstd -xf "$compressed_file"
        ;;
        *)
            echo "Error: unsupported file extension."
            return 1
        ;;
    esac
}

tar_ls() {
    tar -ztvf $1
}

export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.pixi/bin:$PATH"
eval "$(pixi completion --shell bash)"
tmux source ~/.config/tmux/tmux.conf
