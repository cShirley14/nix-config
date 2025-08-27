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

    # "org/gnome/settings-daemon/plugin/media-keys/custom-keybindings/custom0" = {
    #   name = "emote";
    #   command = "emote";
    #   binding = "<Super>period";
    # };
  };
}
