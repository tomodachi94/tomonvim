{ pkgs, inputs }:
let
  extralib = pkgs.callPackage ./lib.nix { };
  tomopkgs-plugins = pkgs.callPackage ./plugin-pkgs { };
in
inputs.tolerable.makeNightlyNeovimConfig "tomonvim" {
  inherit pkgs;
  src = pkgs.lib.fileset.toSource {
    root = ./.;
    fileset = ./tomonvim;
  };
  config = {
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      (extralib.mkLazyPlugin { package = catppuccin-nvim; configModule = "catppuccin-nvim"; })
      tomopkgs-plugins.notify-send-nvim
    ];
  };
}/*.overrideAttrs (old: {
    generatedWrapperArgs = old.generatedWrapperArgs or [] ++ [
      "--suffix" # If the current environment (e.g. a devshell) has a package, we should always use that
      "PATH"
      ":"
      (pkgs.lib.makeBinPath (with pkgs; [
        hunspell
        lexical
        lua-language-server
        mypy
        nil
        proselint
        ruff-lsp
        rust-analyzer
        selene
        stylua
      ]))
    ];

})*/
