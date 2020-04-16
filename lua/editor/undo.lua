require "libs/set"


misc = function ()

  local plugins = {}
  local defer = {}

  --#################### Undo Region ####################

  -- persistent undo
  table.insert(
    defer,
    bindings.set.id("undofile"))

  -- undo history location
  table.insert(
    defer,
    bindings.set.eq("undodir", vim_home .. "/undo"))

  -- maximum number of changes that can be undone
  table.insert(
    defer,
    bindings.set.eq("undolevels", 1000))

  -- maximum number lines to save for undo on a buffer reload
  table.insert(
    defer,
    bindings.set.eq("undoreload", 10000))

  return {
    plugins = plugins,
    defer = defer,
  }
end
