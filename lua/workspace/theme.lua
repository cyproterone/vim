--#################### ############# ####################
--#################### Themes Region ####################
--#################### ############# ####################
require "libs/set"


themes = function ()

  local commands = {}
  local plugins = {}


  -- powerline
  table.insert(plugins, "vim-airline/vim-airline")
  table.insert(plugins, "vim-airline/vim-airline-themes")


  -- colour theme
  table.insert(plugins, "junegunn/seoul256.vim")


  -- iconpack
  table.insert(plugins, "ryanoasis/vim-devicons")


  return {
    commands = commands,
    plugins = plugins
  }
end
