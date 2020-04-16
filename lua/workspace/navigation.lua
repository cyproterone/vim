require "libs/set"


navigation = function ()

  local plugins = {}
  local defer = {}

  --#################### Navigation Region ####################

  -- ui for cmd auto complete
  table.insert(
    defer,
    bindings.set.id("wildmenu"))

  -- auto complete menu
  table.insert(
    defer,
    bindings.set.eq("wildmode", "longest,list,full"))

  table.insert(
    defer,
    bindings.set.minus("complete", "i"))

  -- show command history
  table.insert(
    defer,
    bindings.set.id("showcmd"))


  return {
    plugins = plugins,
    defer = defer,
  }
end
