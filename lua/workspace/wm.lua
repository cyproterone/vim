require "libs/set"


wm = function ()

  local defer = {}
  local plugins = {}

  -- modern split direction
  local modern_split = function ()
    vim.api.nvim_command(bindings.set.id("splitright"))
    vim.api.nvim_command(bindings.set.id("splitbelow"))
  end
  table.insert(defer, modern_split)


  --#################### WM Region ####################

  -- swap windows
  table.insert(plugins, "wesQ3/vim-windowswap")

  -- resize active window
  table.insert(plugins, "camspiers/lens.vim")


  return {
    plugins = plugins,
    defer = defer,
  }
end
