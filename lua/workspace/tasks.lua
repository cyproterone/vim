require "libs/set"


tasks = function ()

  local plugins = {}
  local defer = {}

  --#################### Files Region ####################

  table.insert(plugins, "vim-scripts/vim-auto-save")

  local fs_consistency = function ()
    -- auto load fs changes
    api.nvim_command(bindings.set.id("autoread"))
    -- auto save
    api.nvim_command(bindings.let.g("auto_save", 1))
  end
  table.insert(defer, fs_consistency)


  return {
    plugins = plugins,
    defer = defer,
  }
end
