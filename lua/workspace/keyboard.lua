require "libs/set"


keyboard = function ()

  local defer = {}
  local plugins = {}


  --#################### Keyboard Region ####################

  -- enable smartcase
  table.insert(
    defer,
    bindings.set.id("ignorecase"))
  table.insert(
    defer,
    bindings.set.id("smartcase"))



  -- allow nav keys to wrap around
  table.insert(
    defer,
    bindings.set.plus("whichwrap", "h,l,<,>"))


  -- normalize backspace
  table.insert(
    defer,
    bindings.set.eq("backspace", "indent,eol,start"))


  return {
    defer = defer,
    plugins = plugins
  }
end
