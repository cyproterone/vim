local bindings = require "libs/bindings"
local registry = require "libs/registry"
local io = require "libs/io"


--#################### Misc Region ####################

local misc = function ()

  bindings.set("encoding", "utf-8")

  -- cursor hold time
  bindings.set("updatetime", 300)

  -- show as much as possible
  bindings.set("display", "lastline", [[+=]])

  -- vim session state
  bindings.set("shada", "!", [[+=]])

  -- min lines changed to report
  bindings.set("report", 0)

  -- performance
  bindings.set("ttyfast")

end
registry.defer(misc)


local scroll = function ()

  -- scroll activation margin
  bindings.set("scrolloff", 1)
  bindings.set("sidescrolloff", 1)

  -- normalize cursor pos
  bindings.set("virtualedit", "onemore")
  bindings.map.normal("$", "$<Right>")

end
registry.defer(scroll)


-- integrate remote copy
local registers = function ()

  -- use system clipboard
  -- bindings.set("clipboard", "unnamedplus")

  local pipe = function ()
    local text = bindings.call("getreg", {[[""]]})
    io.pipe("c", text)
  end

  registry.func("Copy_reg", pipe)
  bindings.exec[[command! Clip call Copy_reg()]]

end
registry.defer(registers)


-- clean up where files are stored
local var_files = function ()

  -- backup files
    bindings.set("backupdir", var_home .. "/backup//")

    -- undo files
    bindings.set("undodir", var_home .. "/undo//")

    -- swap files
    bindings.set("directory", var_home .. "/swap//")

end
registry.defer(var_files)


local welcome_screen = function ()

  -- remove welcome message
  bindings.set("shortmess", "I", [[+=]])

  -- open with scratch buffer, like emacs
  local on_new = function (once)
    local name = bindings.call("bufname", {1})
    if name == "" then
      bindings.buf.set(buf, "buftype", "nofile")
    end
    once()
  end

  registry.auto("VimEnter", on_new)

end
registry.defer(welcome_screen)
