local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local registry = require "libs/registry"


--#################### Misc Region ####################

local misc = function ()

  bindings.set("encoding", "utf-8")

  -- more secure
  bindings.set("secure")

  -- cursor hold time
  bindings.set("updatetime", 300)

  -- vim session state
  bindings.set("shada", "!", [[+=]])

  -- min lines changed to report
  bindings.set("report", 0)

  -- no swap files
  bindings.set("noswapfile")

  -- line wrap follow indent
  bindings.set("breakindent")

end
registry.defer(misc)


local scroll = function ()

  -- scroll activation margin
  bindings.set("scrolloff", 0)
  bindings.set("sidescrolloff", 0)

  -- normalize cursor pos
  bindings.set("virtualedit", "onemore,block")
  bindings.map.normal("$", "$<right>")

end
registry.defer(scroll)


-- integrate remote copy
local registers = function ()

  -- use system clipboard
  bindings.set("clipboard", "unnamedplus")

  -- fake DISPLAY for xclip
  env["DISPLAY"] = env["DISPLAY"] or "VIM_FAKE_DISPLAY"

end
registry.defer(registers)


local welcome_screen = function ()

  -- remove welcome message
  bindings.set("shortmess", "I", [[+=]])

  -- open with scratch buffer, like emacs
  local on_new = function (once)
    local name = api.nvim_buf_get_name(1)
    if name == "" then
      api.nvim_buf_set_option(1, "buftype", "nofile")
    end
    once()
  end

  registry.auto("VimEnter", on_new)

end
registry.defer(welcome_screen)
