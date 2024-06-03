{ config, pkgs, lib, vscodeExtensions, ... }:
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

    # VSCodium
    vscode = import ./dot-files/vscode.nix { inherit pkgs vscodeExtensions; };

    # direnv
    direnv = {
      enable = true;
    };

    # fzf
    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [ "--height=80%" "--layout=reverse" ];
    };

    # git
    git = import ./dot-files/git.nix { inherit pkgs; };

    # ssh
    ssh = {
      enable = true;
      # Generates a host section in ~/.ssh/config
      matchBlocks = {
        "github.com" = {
          identityFile = "/run/secrets/github/ssh";
          identitiesOnly = true;
        };
      };
    };

    # zsh
    zsh = import ./dot-files/zsh.nix { inherit lib; };
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry;
    };
  };
}
