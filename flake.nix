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
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      sops-nix,
      nix-vscode-extensions,
      catppuccin,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # Where all the helper pkgs live.
      lib = nixpkgs.lib;
      username = builtins.readFile "/run/secrets/username";
      hostname = builtins.readFile "/run/secrets/hostname";
      os-other = builtins.readFile "/run/secrets/os-other";
    in
    {
      nixosConfigurations = {
        # Hostname.
        ${hostname} = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit username hostname os-other; };
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
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = {
                imports = [
                  ./home/default.nix
                  catppuccin.homeModules.catppuccin
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
