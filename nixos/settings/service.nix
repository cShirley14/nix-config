{ pkgs, lib, ... }: {
  k3s = {
    enable = true;
    role = "server";
    extraFlags = toString [
      "--write-kubeconfig-mode 644"
      # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    ];
  };

  ############################################
  # xserver, an X Window System.
  # see:
  # - https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=services.xserver
  # - https://github.com/NixOS/nixpkgs/issues/94799
  ############################################
  xserver = {
    # Enable the X11 windowing system.
    enable = true;
    # Enable the GNOME Desktop Environment.
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides =
        let
          extensions = lib.concatMapStringsSep ", " (name: "'${name}'")
            [
              "dash-to-panel@jderose9.github.com"
              "apps-menu@gnome-shell-extensions.gcampax.github.com"
              "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
              "appindicatorsupport@rgcjonas.gmail.com"
            ];
        in
        ''
          [org.gnome.desktop.interface]
          clock-format='12h'

          [org.gnome.desktop.screensaver]
          lock-enabled=false

          [org.gnome.desktop.session]
          idle-delay=uint32 0

          [org.gnome.desktop.wm.preferences]
          button-layout='appmenu:minimize,maximize,close'

          [org.gnome.shell]
          disable-user-extensions=false
          enabled-extensions=[ ${extensions} ]
        '';
      extraGSettingsOverridePackages = [
        pkgs.gsettings-desktop-schemas
        pkgs.gnome.gnome-settings-daemon
        pkgs.gnome.gnome-shell
      ];
    };
    videoDrivers = [ "displaylink" "nvidia" ];
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
    excludePackages = [ pkgs.xterm ];
    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Disable extraneous gnome utilities
  gnome.core-utilities.enable = false;

  # PipeWire is a new low-level multimedia framework. It aims to offer capture and
  # playback for both audio and video with minimal latency and support for
  # PulseAudio-, JACK-, ALSA- and GStreamer-based applications. 
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable the OpenSSH daemon.
  openssh.enable = true;

  # Enable CUPS to print documents.
  printing.enable = true;
}
