{ vimPlugins }:
{
  mkLazyPlugin = { package, pname ? args.package.pname, configModule ? pname, lznArgs ? { }, ... }@args: {
    optional = true;
    plugin = vimPlugins.${args.package};
    type = "lua";
    config = ''
      #!/usr/bin/env lua
      local t = vim.json.decode("${builtins.toJSON lznArgs}")
      t[1] = "${args.pname}"
      t["after"] = t["after"] or require("tomo.plugins.${configModule}")
      require("lz.n").load t
    '';
  };
}
