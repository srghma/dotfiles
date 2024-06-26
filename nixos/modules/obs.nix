{ config, lib, pkgs, modulesPath, inputs, settings, localpkgs, ... }:

let
  mypkgs = pkgs.nixpkgsMaster.pkgs;

  obs = mypkgs.wrapOBS {
    plugins = with mypkgs.obs-studio-plugins; [
      advanced-scene-switcher
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
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback # Webcam loopback
  ];

  boot.kernelModules = [
    "v4l2loopback" # Webcam loopback
    # "snd-aloop"
  ];

  environment.systemPackages = [
    obs

    # Webcam packages
    mypkgs.v4l-utils
    mypkgs.android-tools
    mypkgs.adb-sync
    # mypkgs.usbmuxd
  ];

  services.usbmuxd.enable = true; # Webcam loopback
}
