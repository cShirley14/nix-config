# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  stdenv,
  username,
  hostname,
  os-other,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    /home/${username}/${os-other}/hardware-configuration.nix
    # Update Nix
    ./scripts/update.nix
    # Security hardening
    /home/${username}/${os-other}/security.nix
    # Power management for WiFi suspend/resume issues
    # /home/${username}/${os-other}/power-management.nix
  ];

  environment = {
    pathsToLink = [ "/share/zsh" ];
    etc."rancher/k3s/audit-policy.yaml".source = ./k3s-audit-policy.yaml;
    systemPackages = with pkgs; [
      # amazonQCli_1_8_0
      amazon-q-cli
      bashInteractive
      chromium
      delta
      docker
      gimp
      git-crypt
      git
      cheese
      nautilus
      gnome-calculator
      gnome-characters
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      gnupg
      htop
      jq
      k3s
      kubectl
      # libreoffice
      nil
      nixfmt-rfc-style
      nixpkgs-fmt
      nodePackages.prettier
      nordic
      nvd
      openvpn
      pandoc
      pinentry-gnome3
      pre-commit
      runc
      shellcheck
      starship
      steam
      # terraform-docs
      terraform-ls
      terraform
      terminator
      tree
      unzip
      vim
      vlc
      vscodium
      vulkan-tools
      wget
      xorg.xev
    ];
  };

  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts
    noto-fonts-emoji
    fira-code
    fira-code-symbols
  ];

  programs = {
    zsh.enable = true;
    # ssh.
    # GitHub's published ssh keys: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    # GitLab's ssh keys: ssh-keyscan gitlab.com 2>&1 | grep -E '^[^#].*'
    ssh.knownHosts = {
      gitlab-ed25519 = {
        hostNames = [ "gitlab.com" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
      };
      gitlab-rsa = {
        hostNames = [ "gitlab.com" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsj2bNKTBSpIYDEGk9KxsGh3mySTRgMtXL583qmBpzeQ+jqCMRgBqB98u3z++J1sKlXHWfM9dyhSevkMwSbhoR8XIq/U0tCNyokEi/ueaBMCvbcTHhO7FcwzY92WK4Yt0aGROY5qX2UKSeOvuP4D6TPqKF1onrSzH9bx9XUf2lEdWT/ia1NEKjunUqu1xOB/StKDHMoX4/OKyIzuS0q/T1zOATthvasJFoPrAjkohTyaDUz2LN5JoH839hViyEG82yB+MjcFV5MU3N1l1QL3cVUCh93xSaua1N85qivl+siMkPGbO5xR/En4iEY6K2XPASUEMaieWVNTRCtJ4S8H+9";
      };
      gitlab-ecdsa = {
        hostNames = [ "gitlab.com" ];
        publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=";
      };
      github-rsa = {
        hostNames = [ "github.com" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=";
      };
      github-ecdsa = {
        hostNames = [ "github.com" ];
        publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=";
      };
      github-ed25519 = {
        hostNames = [ "github.com" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
    };

  };

  ############
  # Settings #
  ############

  # Nix Flakes.
  nix = import ./settings/nix.nix { inherit pkgs; };

  # Bootloader.
  boot = import ./settings/boot.nix;

  # Networking.
  networking = import /home/${username}/${os-other}/networking.nix { inherit hostname; };

  # Select internationalisation properties.
  i18n = import ./settings/il8n.nix;

  # Services.
  services = import /home/${username}/${os-other}/service.nix {
    inherit
      pkgs
      lib
      config
      username
      hostname
      ;
  };

  # SOPS management.
  sops = import (builtins.readFile "/run/secrets/sops-path") { inherit lib config; };

  users = import ./settings/users.nix { inherit pkgs config username; };

  ####################
  # One Off Settings #
  ####################
  # Set your time zone.
  time.timeZone = "America/New_York";
  # time.timeZone = "America/Chicago";

  # Enable sound with pipewire.
  # sound.enable = true;

  security.rtkit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade = {
    enable = true;
    channel = "https://channels.nixos.org/nixos-unstable";
  };

  virtualisation.docker = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
