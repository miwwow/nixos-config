{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    milk-grub-theme.url = "github:gemakfy/MilkGrub";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      spicetify-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      module_paths = [
        home-manager.nixosModules.home-manager
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
