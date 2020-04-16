require "libs/set"


keyboard = function ()

  local commands = {}
  local plugins = {}


  --#################### Keyboard Region ####################

  -- enable smartcase
  table.insert(
    commands,
    bindings.set.id("ignorecase"))
  table.insert(
    commands,
    bindings.set.id("smartcase"))



  -- allow nav keys to wrap around
  table.insert(
    commands,
    bindings.set.plus("whichwrap", "h,l,<,>"))


  -- normalize backspace
  table.insert(
    commands,
    bindings.set.eq("backspace", "indent,eol,start"))


  return {
    commands = commands,
    plugins = plugins
  }
end
