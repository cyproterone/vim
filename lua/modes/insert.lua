local bindings = require "libs/bindings"
local registry = require "libs/registry"
local theme = require "libs/theme"


--#################### Insert Region ####################

-- add some emacs keys
local emacs_keys = function ()

  -- delete to end of line
  bindings.map.insert("<C-k>", "<C-o>D")

  bindings.map.insert("<M-Left>", "<C-Left>")
  bindings.map.insert("<M-Right>", "<C-Right>")
  bindings.map.insert("<M-Up>", "<C-Up>")
  bindings.map.insert("<M-Down>", "<C-Down>")

end
registry.defer(emacs_keys)


-- add a cursor cross in insert mode
local cursor_cross = function ()

  local enter = function ()
    theme.highlight{CursorLine = {guibg = "#f2d9fa"}}
  end

  local leave = function ()
    theme.highlight{CursorLine = {guibg = "#f1f4f6"}}
  end

  registry.auto("InsertEnter", enter)
  registry.auto("InsertLeave", leave)

end
registry.defer(cursor_cross)
