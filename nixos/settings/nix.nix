{ pkgs, ... }: {
  # Hardlinking duplicate files.
  optimise.automatic = true;
  # Garbage Collection.
  gc = {
    automatic = true;
    options = "--delete-older-than 3d";
  };
  package = pkgs.nixFlakes;
  extraOptions = ''
    experimental-features = nix-command flakes
    stalled-download-timeout = 99999999
  '';
}
