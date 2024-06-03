{ pkgs, config, ... }: {
  defaultUserShell = pkgs.zsh;
  users.randomindie = {
    isNormalUser = true;
    description = "randomindie";
  # hashedPasswordFile = config.sops.secrets.randomindie.path;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      sops
      firefox
    ];
  };
}
