# from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
# unalias fd
# unalias n

# eval "$(direnv hook zsh)"

source $HOME/projects/zsh-nr/index.sh
source $HOME/.dotfiles/secrets-ignored/cachixSigningKey.sh

for file in $HOME/.dotfiles/zsh/*.sh; do
  source $file
done

# tmux-window-name() {
#   (/nix/store/3zg0dvhh2cfk59wh3d1ryhdzx7b5xlqg-tmuxplugin-tmux-window-name-2024-03-08/share/tmux-plugins/tmux-window-name/scripts/rename_session_windows.py &)
# 	# ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
# }
# add-zsh-hook chpwd tmux-window-name

# export TERM=xterm-kitty

# export EDITOR="lvim"

function touch-safe {
  for f in "$@"; do
    [ -d $f:h ] || mkdir -p $f:h && command touch $f
  done
}
# alias touch=touch-safe

function mkdircd {
  mkdir -p "$@"
  cd "$@"
}

function n {
  touch-safe $@
  nvim $@
}

# # Function to recursively migrate Spago projects
# function spago_migrate_recursive() {
#   # Find directories with a file named spago.dhall
#   find . -type f -name 'spago.dhall' -exec sh -c '
#     for file do
#       # Change directory to the directory containing spago.dhall
#       cd "$(dirname "$file")" || exit
#       # Execute spago-migrate
#       spago-migrate
#     done
#   ' sh {} +
# }

alias nii="nix profile install"

path_array=(
  "$HOME/.dotfiles/bin"
  "$HOME/projects/spago-yaml-generate/bin"
  "$HOME/projects/idris2-pack/result/bin"
  "$HOME/projects/Idris2/result/bin"
  # "/nix/store/sk1959yrzisz1qf4p4sgjf55mdngvdqh-idris2-lsp-2024-01-21/bin/"
  "$HOME/projects/zed/result/bin"
  "$HOME/projects/idris2-lsp/result/bin"
  # "$HOME/projects/idris2-lsp/result-newest-not-working/bin"
  # "$HOME/projects/idris2-lsp/result-old-working/bin"
)

export PATH=$(IFS=:; echo "${path_array[*]}"):$PATH

fpath=($HOME/.my-completions $fpath)

# alias spago="$HOME/projects/spago/bin/index.dev.js"

## https://pnpm.io/completion
# pnpm completion zsh > ~/.config/completion-for-pnpm.zsh
source ~/.config/completion-for-pnpm.zsh

# just --completions zsh > ~/.config/completion-for-just.zsh
source ~/.config/completion-for-just.zsh

# unalias z
# eval "$(zoxide init zsh)"
