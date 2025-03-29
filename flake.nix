{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let coreConfig = {
          specialArgs = { inherit inputs; };
          modules = [
            ./nix/configuration.nix
            inputs.home-manager.nixosModules.home-manager {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.joe = import ./nix/home.nix;
            }
          ];
    };
    in
    {
      nixosConfigurations = {
        jdnixlt = nixpkgs.lib.nixosSystem (coreConfig // { 
          modules = coreConfig.modules ++ [
            ./nix/jdnixlt.nix
            ./nix/jdnixlt-hardware.nix
          ];
        });
      };
    };
}
