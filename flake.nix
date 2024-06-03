{
  description = "Local Nixos Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixos-hardware
    , sops-nix
    , nix-vscode-extensions
    , catppuccin
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # Where all the helper pkgs live.
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        # Hostname.
        dev = lib.nixosSystem {
          inherit system;
          # All the nix modules that build up the system configuration.
          modules = [
            ./nixos/default.nix
            nixos-hardware.nixosModules.omen-15-en1007sa
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.randomindie = {
                imports = [
                  ./home/default.nix
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
              home-manager.extraSpecialArgs = {
                vscodeExtensions = nix-vscode-extensions.extensions.${system};
              };
            }
          ];
        };
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
