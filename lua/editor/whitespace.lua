require "libs/set"


whitespace = function ()

  local plugins = {}
  local defer = {}

  --#################### Whitespace Region ####################

  local unsurprising_tab = function ()
    -- insert spaces instead of tabs
    vim.api.nvim_command(bindings.set.id("expandtab"))
    -- smart indentation level
    vim.api.nvim_command(bindings.set.id("autoindent"))
    vim.api.nvim_command(bindings.set.id("smarttab"))
  end
  table.insert(defer, unsurprising_tab)


  return {
    plugins = plugins,
    defer = defer,
  }
end
