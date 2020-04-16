require "libs/set"


mouse = function ()

  local plugins = {}
  local defer = {}

  --#################### Mouse Region ####################

  -- enable mouse
  local normal_mouse = function ()
    vim.api.nvim_command(bindings.set.eq("mouse", "a"))
  end
  table.insert(defer, normal_mouse)


  return {
    plugins = plugins,
    defer = defer,
  }
end
