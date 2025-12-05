{ specialArgs, ... }:
let
  hostname = specialArgs.hostname;
in
{
  imports = [
    ./${hostname}
    ./default-system.nix
  ];
}
