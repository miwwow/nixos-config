{ config, inputs, spicetify-nix, pkgs, ... }:

{
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
    ];
    enabledSnippets = with spicePkgs.snippets; [
      pointer
    ];

    alwaysEnableDevTools = true;    

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
