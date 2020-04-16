require "libs/set"


misc = function ()

  local defer = {}
  local plugins = {}

  --#################### Misc Region ####################

  table.insert(
    defer,
    bindings.set.eq("encoding", "utf-8"))

  table.insert(
    defer,
    bindings.set.id("ttyfast"))


  -- show as much as possible
  table.insert(
    defer,
    bindings.set.eq("display", "lastline"))

  -- more history
  table.insert(
    defer,
    bindings.set.eq("history", 10000))


  -- viminfo include !
  table.insert(
    defer,
    bindings.set.plus("viminfo", "!"))


  return {
    defer = defer,
    plugins = plugins
  }
end
