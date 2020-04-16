require "libs/set"


tasks = function ()

  local defer = {}
  local plugins = {}

  --#################### Files Region ####################

  -- auto load fs changes
  table.insert(
    defer,
    bindings.set.id("autoread"))

  -- auto save
  table.insert(
    plugins,
    "vim-scripts/vim-auto-save")

  table.insert(
    defer,
    bindings.let.g("auto_save", 1))


  return {
    defer = defer,
    plugins = plugins
  }
end
