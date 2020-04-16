require "libs/set"


search = function ()

  local plugins = {}
  local defer = {}

  --#################### Search Region ####################

  local modern_search = function ()
    -- highlight search results
    vim.api.nvim_command(bindings.set.id("hlsearch"))
    -- find result during search
    vim.api.nvim_command(bindings.set.id("incsearch"))
  end
  table.insert(defer, modern_search)


  return {
    plugins = plugins,
    defer = defer,
  }
end
