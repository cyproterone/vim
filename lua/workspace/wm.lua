require "libs/set"


wm = function ()

  local commands = {}
  local plugins = {}

  --#################### WM Region ####################

  -- swap windows
  table.insert(plugins,
               "wesQ3/vim-windowswap")

  -- resize active window
  table.insert(plugins,
               "camspiers/lens.vim")


  return {
    commands = commands,
    plugins = plugins
  }
end
