require "libs/set"


misc = function ()

  local commands = {}
  local plugins = {}

  --#################### Misc Region ####################

  table.insert(
    commands,
    bindings.set.eq("encoding", "utf-8"))

  table.insert(
    commands,
    bindings.set.id("ttyfast"))


  -- show as much as possible
  table.insert(
    commands,
    bindings.set.eq("display", "lastline"))

  -- more history
  table.insert(
    commands,
    bindings.set.eq("history", 10000))


  -- viminfo include !
  table.insert(
    commands,
    bindings.set.plus("viminfo", "!"))


  return {
    commands = commands,
    plugins = plugins
  }
end
