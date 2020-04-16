require "libs/set"


navigation = function ()

  local plugins = {}
  local defer = {}

  --#################### Navigation Region ####################

  local wild = function ()
    -- ui for cmd auto complete
    api.nvim_command(bindings.set.id("wildmenu"))
    -- auto complete menu
    api.nvim_command(bindings.set.eq("wildmode", "longest,list,full"))
    -- hide file history
    api.nvim_command(bindings.set.minus("complete", "i"))
    -- show command history
    api.nvim_command(bindings.set.id("showcmd"))
    -- more history
    api.nvim_command(bindings.set.eq("history", 10000))
  end
  table.insert(defer, wild)


  return {
    plugins = plugins,
    defer = defer,
  }
end
