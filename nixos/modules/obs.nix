{
  config,
  pkgs,
  ...
}:
let
  # mypkgs = pkgs.nixpkgsMaster.pkgs;
  mypkgs = pkgs;

  obs = mypkgs.wrapOBS {
    plugins = with mypkgs.obs-studio-plugins; [
      v4l-utils
      # advanced-scene-switcher
      # obs-pipewire-audio-capture
      droidcam-obs
      # obs-shaderfilter
      # input-overlay
      # obs-source-clone
      # looking-glass-obs
      obs-source-record
      # obs-3d-effect
      # obs-teleport
      obs-backgroundremoval
      # obs-vaapi
      # obs-command-source
      # obs-vintage-filter
      # obs-gstreamer
      # obs-vkcapture
      # obs-hyperion
      # obs-websocket
      # obs-livesplit-one
      # obs-move-transition
      # obs-multi-rtmp
      # obs-ndi
      # wlrobs
      # obs-nvfbc
    ];
  };
in
{
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="HDcam C2900" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # subject.isInGroup("users")
  # subject.user == "srghma"
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.policykit.exec" &&
            action.lookup("program") == "/run/current-system/sw/bin/modprobe" &&
            subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';

  # boot.extraModulePackages = [
  #   config.boot.kernelPackages.v4l2loopback # Webcam loopback
  # ];

  # boot.kernelModules = [
  #   "v4l2loopback" # Webcam loopback
  #   # "snd-aloop"
  # ];
  # services.usbmuxd.enable = true; # Webcam loopback

  environment.systemPackages = [
    obs
    mypkgs.v4l-utils
    mypkgs.android-tools
    mypkgs.adb-sync
    # mypkgs.usbmuxd
  ];
}
