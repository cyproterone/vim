require "libs/set"


themes = function ()

  local commands = {}
  local plugins = {}

  --#################### Intrinsic Region ####################

  -- use 256 colours
  table.insert(commands,
               bindings.set.id("termguicolors"))

  -- highlight cursor location
  table.insert(commands,
               bindings.set.id("cursorline"))


  --#################### Powerline Region ####################

  -- powerline
  table.insert(plugins,
               "vim-airline/vim-airline")

  table.insert(plugins,
               "vim-airline/vim-airline-themes")

  -- always show status line
  table.insert(commands,
               bindings.set.eq("laststatus", 2))


  --#################### Colours Region ####################

  -- colour theme
  table.insert(plugins,
               "junegunn/seoul256.vim")

  -- iconpack
  table.insert(plugins,
               "ryanoasis/vim-devicons")


  return {
    commands = commands,
    plugins = plugins
  }
end
