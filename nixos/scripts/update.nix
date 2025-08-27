{ pkgs, ... }:
let
  nix-home = builtins.readFile "/run/secrets/nix-home";
  update-system = pkgs.writeShellScriptBin "update-system.sh" ''
    #! /bin/sh
    HOME="${nix-home}"
    # Update System
    curr_dir=$(pwd)
    cd "$HOME"

    git config --global user.email "cShirley14@users.noreply.github.com"
    git config --global user.name "cshirley14"

    # Get Old Generation for Comparison
    nixos_old_gen=$(readlink -f /run/current-system)

    # Update Lockfile
    # sudo nix flake lock --recreate-lock-file --commit-lock-file "$HOME"
    nix flake update
    nix flake lock --commit-lock-file "$HOME"

    # Build system.
    sudo nixos-rebuild --impure -I nixos-config="$HOME" --show-trace switch --flake "$HOME"

    # Get New Generation & Report
    nixos_new_gen=$(readlink -f /run/current-system)
    nvd diff "$nixos_old_gen" "$nixos_new_gen"
    cd "$curr_dir"
  '';
in
{
  environment.systemPackages = [ update-system ];
}
