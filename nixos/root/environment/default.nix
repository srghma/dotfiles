{ pkgs, ... }:

with pkgs;

let
  systemPackages = [
    brightnessctl

    nixpkgsMaster.pkgs.keepassxc
    nixpkgsMaster.pkgs.google-chrome-beta
    # nixpkgsUnstable.pkgs.chromium
    nixpkgsUnstable.pkgs.libreoffice
    nixpkgsUnstable.pkgs.zip
    nixpkgsUnstable.pkgs.unzip
    nixpkgsUnstable.pkgs.htop
    nixpkgsUnstable.pkgs.ag
    nixpkgsUnstable.pkgs.ntfs3g
    nixpkgsUnstable.pkgs.alsaUtils

    nixpkgsUnstable.pkgs.okular

    nixpkgsUnstable.pkgs.pavucontrol
    nixpkgsUnstable.pkgs.conky

    nixpkgsUnstable.pkgs.dunst
    nixpkgsUnstable.pkgs.copyq
    nixpkgsUnstable.pkgs.rofi
    nixpkgsUnstable.pkgs.pasystray
    nixpkgsUnstable.pkgs.scrot
    nixpkgsMaster.pkgs.anki
    nixpkgsUnstable.pkgs.xarchiver

    ## misc
    nixpkgsUnstable.pkgs.transmission_gtk
    nixpkgsUnstable.pkgs.feh
    nixpkgsUnstable.pkgs.mpv
    nixpkgsUnstable.pkgs.xclip
    nixpkgsUnstable.pkgs.atool
    nixpkgsUnstable.pkgs.wget
    nixpkgsUnstable.pkgs.gnupg
    nixpkgsUnstable.pkgs.thunderbird
    # psmisc

    nixpkgsUnstable.pkgs.ranger
    # nixpkgsMaster.pkgs.termite
    nixpkgsMaster.pkgs.kitty
    nixpkgsUnstable.pkgs.neovim
    tmux
    vscode
    # nixpkgsUnstable.pkgs.nix

    ## development
    git
    gitAndTools.diff-so-fancy
    gitAndTools.git-crypt
    meld

    # nixpkgsUnstable.pkgs.mplayer

    nixpkgsUnstable.pkgs.nodejs-16_x

    # netcat-openbsd # nc -U /var/run/acpid.socket
    lsof
    openssl

    # xorg.xbacklight
    acpilight

    unar
    unrar

    automake
    autoconf
    # nixpkgsUnstable.autoconf
    gnumake
    gcc
    # inkscape

    nixpkgsUnstable.pkgs.docker_compose
    # mkpasswd

    # android-studio
    ctags
    # filezilla
    firefox
    asciinema
    # tree
    nixpkgsMaster.pkgs.youtube-dl
    tigervnc

    simplescreenrecorder
    # screencast
    # gtk-recordmydesktop
    # kdenlive
    # kazam

    # vagrant
    # nixpkgsMaster.pkgs.ib-tws
    # nixpkgsMaster.pkgs.ib-controller

    # fzf
    # bfg-repo-cleaner # removes passwords from git repo

    # nox
    nix-prefetch-git
    gimp
    # imagemagick

    nixpkgsLocal.pkgs.safeeyes
    # cmus
    mypkgs.hubstaff
    # screen
    # abiword

    # pass
    # qtpass

    # mypkgs.nixfromnpm

    # My packages
    mypkgs.dunsted-volume
    mypkgs.randomize_background
    mypkgs.kb-light
    mypkgs.switch_touchpad
    mypkgs.tmuxx
    # mypkgs.umsf
    # mypkgs.fix-github-https-repo

    # xmind
    jq
    nixpkgsUnstable.pkgs.rubocop

    mypkgs.all-hies.latest # mypkgs.all-hies.unstable.latest

    # nixpkgsUnstable.pkgs.hlint
    # mypkgs.auto-hie-wrapper # use mypkgs.all-hies.unstable.combined ..
    nixpkgsUnstable.pkgs.stack
    # stack

    # haskellPackages.intero
    # stack2nix
    # nixpkgsUnstable.pkgs.cabal2nix

    # nixpkgsUnstable.pkgs.idris

    # sql linters parsers for vim
    # python36Packages.sqlparse
    # sqlint
    # mypkgs.pgFormatter
    # python36Packages.syncthing-gtk
    # mypkgs.arion

    (nixpkgsUnstable.python37.withPackages (ps: with ps; [ pynvim ])) # for denite https://github.com/Shougo/denite.nvim/issues/456

    # for vim
    # nixpkgsUnstable.haskellPackages.hindent
    # nixpkgsUnstable.haskellPackages.stylish-haskell
    # nixpkgsUnstable.haskellPackages.brittany
    # (
    #   let
    #     # oldPkgs = import (fetchTarball https://nixos.org/channels/nixos-18.09/nixexprs.tar.xz) {};
    #     oldPkgs = import <nixos1803> {};
    #   in oldPkgs.haskellPackages.brittany
    # )
    # haskellPackages.Agda
    # nixpkgsUnstable.pkgs.steam

    # mypkgs.pgmodeler
    # mypkgs.obelisk.command

    # Research
    nixpkgsUnstable.pkgs.zotero
    google-drive-ocamlfuse

    dropbox-cli

    # ID kaart
    # nixpkgsUnstable.pkgs.chrome-token-signing
    # nixpkgsUnstable.pkgs.qdigidoc

    nixpkgsUnstable.pkgs.kakoune

    nixpkgsUnstable.pkgs.gfxtablet
    nixpkgsUnstable.pkgs.patchelf
    # nixpkgsUnstable.pkgs.write_stylus
    # xournal
    # nixpkgsUnstable.pkgs.texworks
    # nixpkgsUnstable.pkgs.lex

    # (
    #   texlive.combine {
    #     # tabularx is not available
    #     inherit (pkgs.texlive) scheme-small cleveref latexmk bibtex algorithms cm-super
    #     csvsimple subfigure  glossaries collection-latexextra;
    #   }
    # )

    ruby

    # nixpkgsUnstable.pkgs.gnome3.evolution

    # nixpkgsUnstable.pkgs.ib-tws
    # nixpkgsUnstable.pkgs.ib-controller
    nixpkgsUnstable.pkgs.solargraph
    nixpkgsUnstable.pkgs.awscli2

    mypkgs.easy-purescript-nix-automatic.spago
    mypkgs.easy-purescript-nix-automatic.purs
    mypkgs.easy-purescript-nix-automatic.purty # find ./packages/client/src -name "*.purs" -exec purty --write {} \;
    nixpkgsMaster.pkgs.sd

    nixpkgsUnstable.pkgs.elmPackages.elm
    nixpkgsUnstable.pkgs.elmPackages.elm-format

    # nixpkgsMaster.pkgs.android-studio
    nixpkgsMaster.pkgs.fd
    nixpkgsMaster.pkgs.gitAndTools.gh
    nixpkgsMaster.pkgs.direnv

    # mypkgs.update-module-name-purs
  ];
in
{
  systemPackages = systemPackages;

  variables = {
    EDITOR = "kak";
  };

  etc."resolvconf.conf".text = ''
    name_servers='8.8.8.8'
  '';
}
