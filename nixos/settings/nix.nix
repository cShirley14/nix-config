{ pkgs, ... }:
{
  # Hardlinking duplicate files.
  optimise.automatic = true;
  # Garbage Collection.
  gc = {
    automatic = true;
    options = "--delete-older-than 3d";
  };
  package = pkgs.nixVersions.stable;
  extraOptions = ''
    experimental-features = nix-command flakes
    stalled-download-timeout = 99999999
  '';
  settings = {
    download-buffer-size = 524288000; # 500MB
  };
}
