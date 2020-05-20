local bindings = require "libs/bindings"
local io = require "libs/io"
local registry = require "libs/registry"


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

  -- no swap files
  bindings.set("noswapfile")

end
registry.defer(misc)


local scroll = function ()

  -- scroll activation margin
  bindings.set("scrolloff", 2)
  bindings.set("sidescrolloff", 5)

  -- normalize cursor pos
  bindings.set("virtualedit", "onemore")
  bindings.map.normal("$", "$<Right>")

end
registry.defer(scroll)


-- integrate remote copy
local registers = function ()

  -- use system clipboard
  bindings.set("clipboard", "unnamedplus")

  lua_clipboard = function ()
    local text = fn.getreg([[""]])
    io.pipe("c", text)
  end

  bindings.exec[[command! Clip call v:lua.lua_clipboard()]]

end
registry.defer(registers)


local welcome_screen = function ()

  -- remove welcome message
  bindings.set("shortmess", "I", [[+=]])

  -- open with scratch buffer, like emacs
  local on_new = function (once)
    local name = fn.bufname(1)
    if name == "" then
      bindings.buf(1).set("buftype", "nofile")
    end
    once()
  end

  registry.auto("VimEnter", on_new)

end
registry.defer(welcome_screen)
