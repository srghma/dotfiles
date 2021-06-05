# from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# unalias fd

eval "$(direnv hook zsh)"

source $HOME/projects/zsh-nordicres/index.sh

for file in $HOME/.dotfiles/zsh/*.sh; do
  source $file
done

export EDITOR="nvim"
