{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=pull/333779/head";

  inputs.tolerable.url = "github:wires-org/tolerable-nvim-nix";
  inputs.tolerable.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";
  inputs.tolerable.inputs.nightly.follows = "nightly";

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        neovim = import ./neovim.nix { inherit pkgs inputs; };
      });
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            just
            treefmt
            nixfmt-rfc-style
            stylua
          ];
        };
      });
    };
}
