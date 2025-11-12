{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    milk-grub-theme.url = "github:gemakfy/MilkGrub";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      spicetify-nix,
      ...
    }@inputs: {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.milk-grub-theme.nixosModule
            spicetify-nix.nixosModules.spicetify

            ./configuration.nix
            ./apps
          ];
        };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
