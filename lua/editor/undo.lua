require "libs/set"


misc = function ()

  local plugins = {}
  local defer = {}

  --#################### Undo Region ####################

  local undo_hist = function ()
    -- persistent undo
    vim.api.nvim_command(bindings.set.id("undofile"))
    -- undo history location
    vim.api.nvim_command(bindings.set.eq("undodir", vim_home .. "/undo"))
    -- maximum number of changes that can be undone
    vim.api.nvim_command(bindings.set.eq("undolevels", 1000))
    -- maximum number lines to save for undo on a buffer reload
    vim.api.nvim_command(bindings.set.eq("undoreload", 1000))
  end
  table.insert(defer, undo_hist)


  return {
    plugins = plugins,
    defer = defer,
  }
end
