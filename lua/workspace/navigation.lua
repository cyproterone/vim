require "libs/set"


navigation = function ()

  local commands = {}
  local plugins = {}

  --#################### Navigation Region ####################

  -- ui for cmd auto complete
  table.insert(commands,
               bindings.set.id("wildmenu"))

  -- auto complete menu
  table.insert(commands,
               bindings.set.eq("wildmode", "longest,list,full"))

  table.insert(commands,
               bindings.set.minus("complete", "i"))

  -- show command history
  table.insert(commands,
               bindings.set.id("showcmd"))


  return {
    commands = commands,
    plugins = plugins
  }
end
