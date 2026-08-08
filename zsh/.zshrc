if [[ ! -d $HOME/.zpacker ]]; then
  git clone https://github.com/happyslowly/zpacker $HOME/.zpacker
fi
source $HOME/.zpacker/zpacker.zsh

zpacker plugin 'zdharma-continuum/fast-syntax-highlighting'
zpacker plugin 'agkozak/zsh-z'
zpacker plugin 'zsh-users/zsh-autosuggestions'


# for theme
zpacker theme 'sindresorhus/pure' async.zsh

# local profiles
zpacker local $HOME/.profile.zsh

zpacker end
