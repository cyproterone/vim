require "libs/set"


tasks = function ()

  local commands = {}
  local plugins = {}

  --#################### Files Region ####################

  -- auto load fs changes
  table.insert(
    commands,
    bindings.set.id("autoread"))

  -- auto save
  table.insert(
    plugins,
    "vim-scripts/vim-auto-save")

  table.insert(
    commands,
    bindings.let.g("auto_save", 1))


  return {
    commands = commands,
    plugins = plugins
  }
end
