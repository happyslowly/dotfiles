set -o vi
export EDITOR=nvim
export VISUAL=nvim

# history
HISTSIZE=99999
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

alias ls='lsd -F'
alias grep='grep --color=auto'
alias vi='nvim'
alias vid='neovide'
alias history='history 1'

command -v nix-your-shell >/dev/null && source <(nix-your-shell zsh)
