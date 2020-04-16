require "libs/set"


themes = function ()

  local plugins = {}
  local defer = {}

  --#################### Intrinsic Region ####################

  -- use 256 colours
  table.insert(
    defer,
    bindings.set.id("termguicolors"))

  -- highlight cursor location
  table.insert(
    defer,
    bindings.set.id("cursorline"))

  -- always show status line
  table.insert(
    defer,
    bindings.set.eq("laststatus", 2))


  --#################### Powerline Region ####################

  -- powerline
  table.insert(
    plugins,
    "vim-airline/vim-airline")

  table.insert(
    plugins,
    "vim-airline/vim-airline-themes")

  table.insert(
    defer,
    bindings.let.g("airline_theme", "'tomorrow'"))

  table.insert(
    defer,
    bindings.let.g("airline_powerline_fonts", 1))


  --#################### Colours Region ####################

  -- colour theme
  table.insert(
    plugins,
    "junegunn/seoul256.vim")

  -- table.insert(
  --   defer,
  --   bindings.arbitrary("colorscheme seoul256-light"))

  -- iconpack
  table.insert(
    plugins,
    "ryanoasis/vim-devicons")


  return {
    plugins = plugins,
    defer = defer,
  }
end
