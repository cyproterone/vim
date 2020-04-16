require "libs/set"


wm = function ()

  local defer = {}
  local plugins = {}

  -- modern split direction
  table.insert(
    defer,
    bindings.set.id("splitright"))
  table.insert(
    defer,
    bindings.set.id("splitbelow"))


  --#################### WM Region ####################

  -- swap windows
  table.insert(
    plugins,
    "wesQ3/vim-windowswap")

  -- resize active window
  table.insert(
    plugins,
    "camspiers/lens.vim")


  return {
    plugins = plugins,
    defer = defer,
  }
end
