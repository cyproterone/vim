require "libs/set"


navigation = function ()

  local plugins = {}
  local defer = {}

  --#################### Navigation Region ####################

  local wild = function ()
    -- ui for cmd auto complete
    vim.api.nvim_command(bindings.set.id("wildmenu"))
    -- auto complete menu
    vim.api.nvim_command(bindings.set.eq("wildmode", "longest,list,full"))
    -- hide file history
    vim.api.nvim_command(bindings.set.minus("complete", "i"))
    -- show command history
    vim.api.nvim_command(bindings.set.id("showcmd"))
    -- more history
    vim.api.nvim_command(bindings.set.eq("history", 10000))
  end
  table.insert(defer, wild)


  return {
    plugins = plugins,
    defer = defer,
  }
end
