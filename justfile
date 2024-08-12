cwd := `pwd`

build:
  nix build .#neovim

format:
  treefmt .

repl:
  nix repl --expr 'builtins.getFlake "{{cwd}}"'

