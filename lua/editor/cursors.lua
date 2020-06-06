local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Cursors Region ####################

-- drag regions around
registry.install("matze/vim-move")
local vim_move = function ()

  local get_visual = function ()
    local r1, _ = unpack(api.nvim_buf_get_mark(0, "<"))
    local r2, _ = unpack(api.nvim_buf_get_mark(0, ">"))
    return r1, r2
  end

  local swap = function (visual, down, r1, r2)
    if down then
      local lines = api.nvim_buf_get_lines(0, r1, r2, true)
      api.nvim_buf_set_lines(0, r1, r2, true, lines)
    else
      local lines = api.nvim_buf_get_lines(0, r1, r2, true)
      api.nvim_buf_set_lines(0, r1, r2, true, lines)
    end
  end

  lua_move = function (visual, down)
    if visual then
      local r1, r2 = get_visual()
      swap(true, down, r1, r2)
    else
      local r = unpack(api.nvim_win_get_cursor(0))
      swap(true, down, r, r)
    end
  end

  bindings.map.normal("<M-Up>",   ":lua lua_move(false, false)<CR>")
  bindings.map.normal("<M-Down>", ":lua lua_move(false, true)<CR>")

  bindings.map.visual("<M-Up>",   "<Esc>:lua lua_move(true, false)<CR>")
  bindings.map.visual("<M-Down>", "<Esc>:lua lua_move(true, true)<CR>")

end
registry.defer(vim_move)


-- auto parens
registry.install("Raimondi/delimitMate")
local match_cursor = function ()

  bindings.set("matchpairs", "<:>", [[+=]])

end
registry.defer(match_cursor)
