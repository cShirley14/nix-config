{ pkgs, config, username, ... }: {
  defaultUserShell = pkgs.zsh;
  users.${username}= {
    isNormalUser = true;
    description = username;
    hashedPasswordFile = config.sops.secrets.${username}.path;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      sops
      firefox
    ];
  };
}
