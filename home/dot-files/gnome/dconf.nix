{
  settings = {
    # Enable Extensiosn
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "@as []";
    };

    # 12hr clock
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      gtk-theme = "Nordic";
    };

    # Power management - shutdown instead of suspend
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "shutdown";
      sleep-inactive-battery-type = "shutdown";
    };

    # Disable auto-login to require login after shutdown
    "org/gnome/login-screen" = {
      enable-automatic-login = false;
    };

    # "org/gnome/settings-daemon/plugin/media-keys/custom-keybindings/custom0" = {
    #   name = "emote";
    #   command = "emote";
    #   binding = "<Super>period";
    # };
  };
}
