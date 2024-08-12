{ vimUtils, fetchFromGitHub, libnotify }:
vimUtils.buildVimPlugin {
  name = "notify-send-nvim";
  src = fetchFromGitHub {
    owner = "Ajnasz";
    repo = "notify-send.nvim";
    rev = "36cea8c6b7b1d4246f701adb2aaa30328500857c";
    hash = "sha256-yO2k5rArm3zqg6c/gm5a48auhWbPbWoW+sSYCLFqN4Y=";
  };
  postPatch = ''
    rm -rf lua
    cp ${./Makefile-fennel} ./Makefile
    substituteInPlace fnl/notify-send.fnl \
      --replace-fail "notify-send" "${libnotify}/bin/notify-send"
  '';
  buildPhase = ''
    make
  '';
}
