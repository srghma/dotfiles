{ pkgs, ... }:

with pkgs;

rec {
  # see https://github.com/NixOS/nixpkgs/blob/cad1c18743699fa7458f1e49f6cfab0b86b024e9/nixos/modules/services/databases/postgresql.nix#L12

  # To connect by local:
  # HOST_IP=`ip -4 addr show scope global dev docker0 | grep inet | awk '{print $2}' | cut -d / -f 1`
  # or
  # HOST_IP=`ip -4 addr show wlp3s0 | grep inet | awk '{print $2}' | cut -d / -f 1`
  # psql --dbname=postgres://foo:bar@$HOST_IP:5432/dev_db

  # To connect by from docker container (https://github.com/docker/for-linux/issues/264#issuecomment-402575483):
  # psql --dbname=postgres://foo:bar@$(ip route|awk '/default/ { print $3 }'):5432/dev_db

  # postgresql = {
  #   enable = true;

  #   extraConfig = ''
  #     listen_addresses = '*'
  #   '';

  #   authentication = ''
  #     # Allow login as user foo from any ip (0.0.0.0/0) by encrypted password (md5)
  #     host all foo 0.0.0.0/0 md5
  #   '';

  #   package = pkgs.postgresql100;

  #   initialScript = pkgs.writeText "postgres-initScript" ''
  #     CREATE ROLE foo WITH LOGIN PASSWORD 'bar' CREATEDB;
  #     CREATE DATABASE dev_db;
  #     GRANT ALL PRIVILEGES ON DATABASE dev_db TO foo;
  #   '';
  # };

  openssh.enable = true;
  xbanish.enable = true;
  compton.enable = true;
  # keybase.enable = true;

  gnome3.gnome-online-accounts.enable = true;
  gnome3.gnome-user-share.enable = true;
  gnome3.tracker.enable = true;
  gnome3.evolution-data-server.enable = true;
  packagekit.enable = false;
  # gnome3.gnome-keyring.enable = false;
  gnome3.tracker-miners.enable = false;
  geoclue2.enable = false;
  dleyna-renderer.enable = false;
  dleyna-server.enable = false;
  safeeyes.enable = false;
  # nextcloud-client.enable = true;

  # zfs.autoScrub.enable = true;

  # redshift = {
  #   enable = true;
  #   temperature.night = 3000;
  #   brightness.night = "0.5";
  # };

  acpid = {
    enable = true;
    handlers = {
      power = {
        event = "button/power";
        action = "${pkgs.systemd}/bin/systemctl poweroff";
      };
    };
  };

  logind.lidSwitch = "ignore"; # Specifies what to be done when the laptop lid is closed.

  xserver = {
    enable = true;

    layout = "us,ru";
    xkbOptions = "caps:swapescape,grp:rctrl_rshift_toggle";
    xkbVariant = "qwerty";
    libinput.enable = true;

    dpi = 96;

    deviceSection = ''
      Option "DPI" "96 x 96"
    '';

    windowManager = {
      i3.enable = true;
    };

    desktopManager = {
      gnome3.enable = true;
    };

    displayManager = {
      defaultSession = "none+i3";

      lightdm = {
        enable = true;
      };

      autoLogin = {
        enable = true;
        user = "srghma";
      };

      # ${xorg.xkbcomp}/bin/xkbcomp ${../../../layouts/en_ru} $DISPLAY &
      sessionCommands = ''
        ${xorg.xkbcomp}/bin/xkbcomp /home/srghma/.dotfiles/layouts/en_ru_swapped $DISPLAY
      '';
    };
  };

  # hostapd = {
  #   enable        = true;
  #   wpaPassphrase = "passphrase";
  #   ssid          = "srghma-nixos";
  #   interface     = "wlp3s0";
  # };

  emacs.enable = false;

  # ID kaart
  # pcscd.enable = true;

  lorri.enable = true;

  nginx = {
    enable = false;
    # recommendedGzipSettings = true;
    # recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    statusPage = true;

    virtualHosts."localhost" = {
      locations = {
        "/" = {
          proxyPass = "http://127.0.0.1:3001"; # client
        };
        "/graphql" = {
          proxyPass = "http://127.0.0.1:3000"; # server
          proxyWebsockets = true;
        };
        "/graphiql" = {
          proxyPass = "http://127.0.0.1:3000"; # server
        };
      };
    };
  };
}
