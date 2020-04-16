require "libs/set"


cursors = function ()

  local defer = {}
  local plugins = {}

  --#################### Cursors Region ####################

  table.insert(
    plugins,
    "terryma/vim-expand-region")

  -- multi cursors
  table.insert(
    plugins,
    "terryma/vim-multiple-cursors")

  -- drag regions around
  table.insert(
    plugins,
    "matze/vim-move")

  -- easy quoting
  table.insert(
    plugins,
    "tpope/vim-surround")

  -- auto parens
  table.insert(
    plugins,
    "Raimondi/delimitMate")

  return {
    defer = defer,
    plugins = plugins
  }
end
