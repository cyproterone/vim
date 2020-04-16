require "libs/set"


mouse = function ()

  local defer = {}
  local plugins = {}

  --#################### Mouse Region ####################

  -- enable mouse
  table.insert(
    defer,
    bindings.set.eq("mouse", "a"))


  return {
    defer = defer,
    plugins = plugins
  }
end
