{
  config,
  pkgs,
  lib,
  vscodeExtensions,
  ...
}:
{
  # 🏡 Home Manager essential settings.
  home = import ./settings/home-default-settings.nix { inherit pkgs config; };

  # 👣 Gnome
  dconf = import ./dot-files/gnome/dconf.nix;

  # Local programs.
  programs = {
    # 🏡 Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Vim
    vim = import ./dot-files/vim/vim.nix { inherit pkgs; };

    # Starship
    starship = import ./dot-files/starship.nix;

    # Terminator
    terminator = import ./dot-files/terminator.nix { inherit pkgs; };

    # VSCodium
    vscode = import ./dot-files/vscode.nix { inherit pkgs vscodeExtensions; };
    # vscode = import ./dot-files/vscode-official.nix { inherit pkgs vscodeExtensions; };

    # direnv
    direnv = {
      enable = true;
    };

    # fzf
    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height=80%"
        "--layout=reverse"
      ];
    };

    # git
    git = import ./dot-files/git.nix { inherit pkgs; };

    # ssh
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      # Generates a host section in ~/.ssh/config
      matchBlocks = {
        "*" = {
          # Secure default settings
          serverAliveInterval = 60;
          serverAliveCountMax = 3;
          compression = true;
          controlMaster = "auto";
          controlPath = "/tmp/ssh-control-%r@%h:%p";
          controlPersist = "10m";
        };
        "github.com" = {
          identityFile = "/run/secrets/github/ssh";
          identitiesOnly = true;
        };
      };
    };

    # zsh
    zsh = import ./dot-files/zsh.nix { inherit lib; };
  };

  catppuccin = {
    starship.enable = true;
    flavor = "macchiato";
    # enable = true;
    # optionally configure the extension settings, defaults are shown below:
    # vscode.profiles.default = {
    #   accent = "mauve";
    #   settings = {
    #     boldKeywords = true;
    #     italicComments = true;
    #     italicKeywords = true;
    #     colorOverrides = { };
    #     customUIColors = { };
    #     workbenchMode = "default";
    #     bracketMode = "rainbow";
    #     extraBordersEnabled = false;
    #   };
    # };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentry = {
        package = pkgs.pinentry-gnome3;
      };
    };
  };
}
