require "libs/set"


wm = function ()

  local commands = {}
  local plugins = {}

  -- modern split direction
  table.insert(commands,
               bindings.set.id("splitright"))
  table.insert(commands,
               bindings.set.id("splitbelow"))


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
