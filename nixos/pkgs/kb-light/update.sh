#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-git

SCRIPT_DIR=$(dirname "$(readlink -f "$BASH_SOURCE")")
new_revision=$(nix-prefetch-git https://github.com/srghma/kb-light)
echo "$new_revision" > "$SCRIPT_DIR/revision.json"
