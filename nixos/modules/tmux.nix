{
  pkgs,
  lib,
  ...
}:
with lib;
let
  username = "srghma";

  pythonInputs = (
    pkgs.python3.withPackages (
      p: with p; [
        libtmux
        pip
      ]
    )
  );
  # NIX_BIN_PATH="${builtins.getEnv "HOME"}/.nix-profile/bin"
  # # Update USR_BIN_REMOVER with .nix-profile PATH
  # sed -i "s|^USR_BIN_REMOVER.*|USR_BIN_REMOVER = (r\'^$NIX_BIN_PATH/(.+)( --.*)?\', r\'\\\g<1>\')|" $target/scripts/rename_session_windows.py
  #
  # # Update substitute_sets with .nix-profile PATHs
  # sed -i "s|^\ssubstitute_sets: List.*|    substitute_sets: List[Tuple] = field(default_factory=lambda: [(\'/$NIX_BIN_PATH/(.+) --.*\', \'\\\g<1>\'), (r\'.+ipython([32])\', r\'ipython\\\g<1>\'), USR_BIN_REMOVER, (r\'(bash) (.+)/(.+[ $])(.+)\', \'\\\g<3>\\\g<4>\')])|" $target/scripts/rename_session_windows.py
  #
  # # Update dir_programs with .nix-profile PATH for applications
  # sed -i "s|^\sdir_programs: List.*|    dir_programs: List[str] = field(default_factory=lambda: [["$NIX_BIN_PATH/vim", "$NIX_BIN_PATH/vi", "$NIX_BIN_PATH/git", "$NIX_BIN_PATH/nvim"]])|" $target/scripts/rename_session_windows.py

  tmux-window-name = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-window-name";
    version = "2024-03-08";
    src = pkgs.fetchFromGitHub {
      owner = "ofirgall";
      repo = "tmux-window-name";
      rev = "dc97a79ac35a9db67af558bb66b3a7ad41c924e7";
      sha256 = "sha256-o7ZzlXwzvbrZf/Uv0jHM+FiHjmBO0mI63pjeJwVJEhE=";
    };
    nativeBuildInputs = [ pkgs.makeWrapper ];
    rtpFilePath = "tmux_window_name.tmux";
    postInstall = ''
      for f in tmux_window_name.tmux scripts/rename_session_windows.py; do
        wrapProgram $target/$f \
          --prefix PATH : ${lib.makeBinPath [ pythonInputs ]}
      done
    '';
  };

  plugins = [
    # {
    #   plugin = tmux-window-name;
    #   extraConfig = ''
    #     set -g @tmux_window_name_substitute_sets \
    #       "[ \
    #         (r'^(/usr)?/bin/(.+)', r'\g<2>'), \
    #         (r'/nix/store/[a-z0-9\.-]+/bin/(.+) -u .*', r'\g<1>'), \
    #         (r'/nix/store/[a-z0-9\.-]+/bin/(.+) .*', r'\g<1>'), \
    #         (r'/run/current-system/sw/bin/(.+) --.*', r'\g<1>'), \
    #         (r'/home/srghma/.nix-profile/bin/(.+) --.*', r'\g<1>'), \
    #         (r'/etc/profiles/per-user/srghma/bin/(.+) --.*', r'\g<1>') \
    #       ]"
    #     set -g @tmux_window_name_dir_programs \
    #       "[ \
    #         'nvim', 'vim', 'vi', 'git', \
    #         '/home/srghma/.nix-profile/bin/nvim', \
    #         '/etc/profiles/per-user/srghma/bin/nvim' \
    #       ]"
    #     set -g @tmux_window_name_log_level "'DEBUG'"
    #   '';
    # }

    # {
    #   plugin = pkgs.tmuxPlugins.catppuccin;
    #   extraConfig = ''
    #     set -g @catppuccin_flavour 'mocha'
    #
    #     # set -g @catppuccin_user off
    #     # set -g @catppuccin_host off
    #     set -g @catppuccin_date_time "%Y-%m-%d %H:%M"
    #
    #     set -g @catppuccin_window_left_separator "█"
    #     set -g @catppuccin_window_right_separator "█"
    #     set -g @catppuccin_window_number_position "right"
    #     set -g @catppuccin_window_middle_separator "  █"
    #     set -g @catppuccin_window_status_enable "no"
    #     set -g @catppuccin_window_default_fill "number"
    #     set -g @catppuccin_window_default_text "#W"
    #     set -g @catppuccin_window_current_fill "number"
    #     set -g @catppuccin_window_current_text "#W"
    #
    #     set -g @catppuccin_status_modules_left ""
    #     set -g @catppuccin_status_modules_right "host prefix_highlight"
    #     set -g @catppuccin_status_left_separator "█"
    #     set -g @catppuccin_status_right_separator "█ "
    #     set -g @catppuccin_status_right_separator_inverse "no"
    #     set -g @catppuccin_status_fill "all"
    #     set -g @catppuccin_status_connect_separator "no"
    #   '';
    # }
    # {
    #   plugin = pkgs.tmuxPlugins.rose-pine;
    #   extraConfig = ''
    #     set -g @rose_pine_variant 'main'
    #     set -g @rose_pine_bar_bg_disable 'on'
    #     set -g @rose_pine_date_time "%d.%m. %H:%M"
    #     set -g @rose_pine_directory 'off'
    #     # set -g @rose_pine_bar_bg_disabled_color_option 'default'
    #     # set -g @rose_pine_status_right_append_section '#{tmux_mode_indicator}'
    #
    #     # set -g @rose_pine_default_window_behavior 'on'
    #
    #     set -g @rose_pine_disable_active_window_menu 'on'
    #     set -g @rose_pine_show_current_program 'on'
    #     set -g @rose_pine_show_pane_directory 'on'
    #
    #     set -g @rose_pine_left_separator ":"
    #     set -g @rose_pine_right_separator " "
    #     set -g @rose_pine_window_status_separator " | "
    #   '';
    # }
    pkgs.tmuxPlugins.mode-indicator
    {
      # Not necessary due to WezTerm's builtin URL highlighting / copying
      plugin = pkgs.tmuxPlugins.tmux-thumbs;
      extraConfig = ''
        set -g @thumbs-command 'echo -n {} | copyq copy -'
        set -g @thumbs-key F
      '';
    }
  ];

  pluginName = p: if types.package.check p then p.pname else p.plugin.pname;

  extraConfigPlugins = ''
    # ============================================= #
    # Load plugins without Home Manager             #
    # --------------------------------------------- #

    ${
      (concatMapStringsSep "\n\n" (p: ''
        # ${pluginName p}
        # ---------------------
        ${p.extraConfig or ""}
        run-shell ${if types.package.check p then p.rtp else p.plugin.rtp}
      '') plugins)
    }
    # ============================================= #
  '';
in
{
  programs.tmux = {
    enable = true;
    # package = pkgs.tmux;
    clock24 = true;
    keyMode = "vi";
    newSession = true;
    historyLimit = 30000;
    terminal = "xterm-256color";
    shortcut = "a";

    # # Quick escape back to insert mode in nvim
    # set -sg escape-time 10
    #
    # # Setup 'v' to begin selection as in Vim
    # bind-key -T edit-mode-vi Up send-keys -X history-up
    # bind-key -T edit-mode-vi Down send-keys -X history-down
    # unbind-key -T copy-mode-vi Space     ;   bind-key -T copy-mode-vi v send-keys -X begin-selection
    # unbind-key -T copy-mode-vi Enter     ;   bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace xclip"
    # unbind-key -T copy-mode-vi C-v       ;   bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    # unbind-key -T copy-mode-vi [         ;   bind-key -T copy-mode-vi [ send-keys -X begin-selection
    # unbind-key -T copy-mode-vi ]         ;   bind-key -T copy-mode-vi ] send-keys -X copy-selection
    #
    # # for nested tmux sessions
    # set -g prefix C-a
    # bind-key a send-prefix
    #
    # setw -g aggressive-resize on
    #
    # # basic settings
    # set-window-option -g xterm-keys on # for vim
    # set-window-option -g monitor-activity on
    # # use mouse # More on mouse support http://floriancrouzat.net/2010/07/run-tmux-with-mouse-support-in-mac-os-x-terminal-app/
    # set -g history-limit 30000
    # set -g mouse on
    #
    # # start panes at 1 - 0 is too far away :)
    # set -g base-index 1
    # set -g pane-base-index 1
    # set-window-option -g pane-base-index 1
    # set-option -g renumber-windows on
    #
    # # Undercurl
    # set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
    # set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
    #
    # # FZF-TMUX WINDOW SWITCH
    # bind-key    -T prefix s                choose-tree
    # bind-key    -T prefix W                choose-window
    # bind        -T prefix w                run-shell -b "$HOME/.dotfiles/scripts/tmux-switch-panes.sh"
    #
    # # Titles (window number, program name, active (or not))
    # set-option -g set-titles on
    # set-option -g set-titles-string '#H #W'
    #
    # # Unbinds
    # unbind j
    # unbind C-b # unbind default leader key
    # unbind '"' # unbind horizontal split
    # unbind %   # unbind vertical split
    #
    # # reload tmux conf
    # bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded"
    #
    # # new split in current pane (horizontal / vertical)
    # bind-key c split-window -v # split pane horizontally
    # bind-key v split-window -h # split pane vertically
    #
    # # windows
    # bind-key m new-window
    # bind C-j previous-window
    # bind C-k next-window
    # bind-key C-a last-window # C-a C-a for last active window
    # bind A command-prompt "rename-window %%"
    #
    # # use the vim motion keys to move between panes
    # bind-key h select-pane -L
    # bind-key j select-pane -D
    # bind-key k select-pane -U
    # bind-key l select-pane -R
    #
    # # Resizing
    # bind-key C-h resize-pane -L 5
    # bind-key C-j resize-pane -D 5
    # bind-key C-k resize-pane -U 5
    # bind-key C-l resize-pane -R 5
    #
    # # use vim motion keys while in copy mode
    # setw -g mode-keys vi
    #
    # # layouts
    # bind o select-layout 4582,187x95,0,0[187x69,0,0,0,187x25,0,70,23]
    # bind C-r rotate-window

    extraConfig = ''
      ${extraConfigPlugins}
    '';
  };
}
