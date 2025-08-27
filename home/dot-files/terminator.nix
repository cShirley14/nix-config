{ pkgs, ... }:
{
  enable = true;
  config = {
    profiles = {
      default = {
        # Font settings
        font = "Cascadia Code 15";
        use_system_font = false;
        # Background image using absolute path
        background_image = "nix-config/home/images/ghibli.jpg";
        # Enable background image
        background_type = "image";
        # Hide title bar
        show_titlebar = false;
      };
    };
  };
}
