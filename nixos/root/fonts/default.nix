{ pkgs, ... }:
{
  fontDir.enable = true;
  enableGhostscriptFonts = true;

  packages = with pkgs; [
    corefonts
    ubuntu_font_family
    powerline-fonts
    font-awesome
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    emojione
    kanji-stroke-order-font
    ipafont

    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts

    # (iosevka.override {
    #   set = "custom";
    #   privateBuildPlan = {
    #     family = "Iosevka";
    #     # design = [ "ligset-haskell" ];
    #     # design = [ "slab" "ligset-haskell" ];
    #     design = [ "slab" "ligset-dlig" ];
    #     # design = [ "slab" "ligset-dlig" ];
    #     # design = [ "common styles" "sans" "ligset-haskell" ];
    #   };
    # })

    # monoid
    # hasklig
    # fira-code
    # fira-code-symbols
    jetbrains-mono

    # the font package loads very slow (https://github.com/NixOS/nixpkgs/issues/47921)
    # to prevent error - download for github manually from
    # https://github.com/ryanoasis/nerd-fonts/archive/2.0.0.tar.gz
    # and then
    # EXPECTED_HASH=09i467hyskvzj2wn5sj6shvc9pb0a0rx5iknjkkkbg1ng3bla7nm
    # nix-prefetch-url --type sha256 --unpack --name source file:///home/$USER/Downloads/nerd-fonts-2.0.0.tar.gz $EXPECTED_HASH
    # (find expected hash https://github.com/NixOS/nixpkgs/blob/92a047a6c4d46a222e9c323ea85882d0a7a13af8/pkgs/data/fonts/nerdfonts/default.nix#L6-L11)
    # nerdfonts

    nerd-fonts.inconsolata
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
  ];

  fontconfig = {
    # dpi = 96;
    #dpi = 180;
    # hinting.autohint = false;
    # ultimate.enable = false;
    # penultimate.enable = false;
    # useEmbeddedBitmaps = true;
    # antialias = true;

    defaultFonts = {
      monospace = [
        "Fira Code"
        "FiraCode Nerd Font"
        "DejaVu Sans Mono"
        "Noto Mono"
      ];
      sansSerif = [
        "Fira Sans"
        "Ubuntu"
        "DejaVu Sans"
        "Noto Sans"
      ];
      serif = [
        "Roboto Slab"
        "PT Serif"
        "Liberation Serif"
        "Noto Serif"
      ];
    };
  };
}
