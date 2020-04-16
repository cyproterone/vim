require "libs/set"


mouse = function ()

  local plugins = {}
  local defer = {}

  --#################### Mouse Region ####################

  -- enable mouse
  table.insert(
    defer,
    bindings.set.eq("mouse", "a"))


  return {
    plugins = plugins,
    defer = defer,
  }
end
