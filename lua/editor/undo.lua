require "libs/set"


misc = function ()

  local commands = {}
  local plugins = {}

  --#################### Undo Region ####################

  -- persistent undo
  table.insert(
    commands,
    bindings.set.id("undofile"))

  -- undo history location
  table.insert(
    commands,
    bindings.set.eq("undodir", vim_home .. "/undo"))

  -- maximum number of changes that can be undone
  table.insert(
    commands,
    bindings.set.eq("undolevels", 1000))

  -- maximum number lines to save for undo on a buffer reload
  table.insert(
    commands,
    bindings.set.eq("undoreload", 10000))

  return {
    commands = commands,
    plugins = plugins
  }
end
