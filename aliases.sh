#alias mamba=micromamba
#alias conda=micromamba
alias wormhole=wormhole-william
alias fsdu="dust -DRrp -z 1G"
alias ls="ls --color=auto"
alias vim=nvim

nless() {
    unnaf -c "$@" |less
}

xv() {
  xan view -l 20 "$@"
}

#for tab completions
complete -o default -o bashdefault -o filenames xv


dufolders () {
    find ./ -maxdepth 1 -type d -print0 | xargs -0 -n1 -P4 du -sh
}


#tv () {
# first_line=$(head -n1 "$1")
# if [[ ! $first_line == *$'\t'* && $first_line == *,* ]]; then
# csvtk pretty $1 | less --header 1
# else
# csvtk -t pretty $1 | less --header 1
# fi
#}

tv () {
 csvlens -d auto $1
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
