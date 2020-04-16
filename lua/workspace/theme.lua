require "libs/set"


themes = function ()

  local plugins = {}
  local defer = {}

  --#################### Intrinsic Region ####################

  local intrinsic = function ()
    -- use 256 colours
    vim.api.nvim_command(bindings.set.id("termguicolors"))
    -- highlight cursor location
    vim.api.nvim_command(bindings.set.id("cursorline"))
    -- always show status line
    vim.api.nvim_command(bindings.set.eq("laststatus", 2))
  end
  table.insert(defer, intrinsic)

  --#################### Powerline Region ####################

  -- powerline
  table.insert(plugins, "vim-airline/vim-airline")

  table.insert(plugins, "vim-airline/vim-airline-themes")

  local powerline = function ()
    vim.api.nvim_command(bindings.let.g("airline_theme", "'tomorrow'"))
    vim.api.nvim_command(bindings.let.g("airline_powerline_fonts", 1))
  end
  table.insert(defer, powerline)

  --#################### Colours Region ####################

  -- colour theme
  table.insert(plugins, "junegunn/seoul256.vim")

  local colours = function ()
    vim.api.nvim_command(bindings.arbitrary("colorscheme seoul256-light"))
  end
  table.insert(defer, colours)


  -- iconpack
  table.insert(plugins, "ryanoasis/vim-devicons")


  return {
    plugins = plugins,
    defer = defer,
  }
end
