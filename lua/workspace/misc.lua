require "libs/set"


misc = function ()

  local plugins = {}
  local defer = {}

  --#################### Misc Region ####################

  local misc = function ()
    vim.api.nvim_command(bindings.set.id("nocompatible"))
    vim.api.nvim_command(bindings.set.eq("encoding", "utf-8"))
    vim.api.nvim_command(bindings.set.id("ttyfast"))
    -- show as much as possible
    vim.api.nvim_command(bindings.set.plus("display", "lastline"))
    -- viminfo include !
    vim.api.nvim_command(bindings.set.plus("viminfo", "!"))
  end
  table.insert(defer, misc)


  return {
    plugins = plugins,
    defer = defer,
  }
end
