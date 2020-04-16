require "libs/set"


mouse = function ()

  local plugins = {}
  local defer = {}

  --#################### Mouse Region ####################

  -- enable mouse
  local normal_mouse = function ()
    bindings.set("mouse", "a")
  end
  table.insert(defer, normal_mouse)


  return {
    plugins = plugins,
    defer = defer,
  }
end
