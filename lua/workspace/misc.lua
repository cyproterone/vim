require "libs/set"


misc = function ()

  local plugins = {}
  local defer = {}

  --#################### Misc Region ####################

  local misc = function ()
    api.nvim_command(bindings.set.id("nocompatible"))
    api.nvim_command(bindings.set.eq("encoding", "utf-8"))
    api.nvim_command(bindings.set.id("ttyfast"))
    -- show as much as possible
    api.nvim_command(bindings.set.plus("display", "lastline"))
    -- viminfo include !
    api.nvim_command(bindings.set.plus("viminfo", "!"))
  end
  table.insert(defer, misc)


  return {
    plugins = plugins,
    defer = defer,
  }
end
