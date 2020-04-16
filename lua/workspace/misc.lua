require "libs/set"


misc = function ()

  local plugins = {}
  local defer = {}

  --#################### Misc Region ####################

  local misc = function ()
    bindings.set("nocompatible")
    bindings.set("encoding", "utf-8")
    bindings.set("ttyfast")
    -- show as much as possible
    bindings.set("display", "lastline", [[+=]])
    -- viminfo include !
    bindings.set("viminfo", "!", [[+=]])
  end
  table.insert(defer, misc)


  return {
    plugins = plugins,
    defer = defer,
  }
end
