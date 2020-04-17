local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Intrinsic Region ####################

local wild = function ()

  -- ui for cmd auto complete
  bindings.set("wildmenu")
  bindings.set("wildmode", "full")
  bindings.set("wildignorecase")

  -- hide file history
  bindings.set("complete", "i", [[-=]])

  -- more history
  bindings.set("history", 10000)

end
table.insert(defer, wild)


--#################### FZF Region ####################

-- fzf
table.insert(plugins, "junegunn/fzf")
table.insert(plugins, "junegunn/fzf.vim")
local fzf = function ()

  -- fzf use fd
  bindings.env("FZF_DEFAULT_COMMAND", [['fd -H -t f']])

  -- fzf use history
  bindings.let("fzf_history_dir", [[']] .. var_home .. "/fzf//" .. [[']])

  -- fzf use preview
  bindings.let("fzf_preview_window", [['right:60%']])


  -- keybindings
  bindings.map.normal("<C-p>", ":Commands<CR>")
  bindings.map.normal("<Leader>f", ":FZF<CR>")
  bindings.map.normal("<Leader>r", ":Rg<CR>")
  bindings.map.normal("<Leader>s", ":BLines<CR>")

end
table.insert(defer, fzf)


return {
  plugins = plugins,
  defer = defer,
}
