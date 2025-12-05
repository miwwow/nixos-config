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
    }@inputs:
    let
      inherit (self) outputs;

      module_paths = [
        inputs.milk-grub-theme.nixosModule
        spicetify-nix.nixosModules.spicetify

        ./system
        ./desktop
        ./apps
      ];
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
            hostname = "nixos";
          };
          modules = module_paths;
        };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
