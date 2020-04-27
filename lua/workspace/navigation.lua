local bindings = require "libs/bindings"


local plugins = {}
local defer = {}

--#################### Intrinsic Region ####################

local wild = function ()

  -- ui for cmd auto complete
  bindings.set("wildmenu")
  bindings.set("wildmode", "list:longest,full")
  bindings.set("wildignorecase")
  bindings.set("wildoptions", "tagfile")

  -- more history
  bindings.set("history", 10000)

end
table.insert(defer, wild)


-- enable smartcase
local smartcase = function ()

  bindings.set("ignorecase")
  bindings.set("smartcase")

  bindings.auto{group = "smartcase_no",
                events = "CmdLineEnter",
                exec = "set nosmartcase"}

  bindings.auto{group = "smartcase_yes",
                events = "CmdLineLeave",
                exec = "set smartcase"}

end
table.insert(defer, smartcase)


--#################### FZF Region ####################

-- fzf
table.insert(plugins, "junegunn/fzf")
table.insert(plugins, "junegunn/fzf.vim")
local fzf_cmds = function ()

  bindings.source(scripts_home .. "/fzf.vim")

end
table.insert(defer, fzf_cmds)


local fzf = function ()

  -- fzf remove default border
  local fzf_opts = os.getenv("FZF_DEFAULT_OPTS")
  local fzf_newopts = fzf_opts .. " --no-border"
  bindings.env("FZF_DEFAULT_OPTS", fzf_newopts)

  -- fzf use fd
  bindings.env("FZF_DEFAULT_COMMAND", "fd -H -t f")

  -- fzf use history
  bindings.let("fzf_history_dir", var_home .. "/fzf//")

  -- fzf use preview
  bindings.let("fzf_preview_window", "right:wrap")

  bindings.let("fzf_layout",
               {window = {
                   width = 0.8,
                   height = 0.8}})

  -- keybindings
  bindings.map.normal("<C-p>", ":Commands<CR>")
  bindings.map.normal("<Leader>p", ":Files<CR>")
  bindings.map.normal("<Leader>P", ":History<CR>")
  bindings.map.normal("<Leader>o", ":BLines<CR>")
  bindings.map.normal("<Leader>O", ":Rg ")
  bindings.map.normal("<Leader>m", ":Maps<CR>")

end
table.insert(defer, fzf)


--#################### Navi Region ####################

-- use [ ] to navigate various lists, ie quickfix
table.insert(plugins, "tpope/vim-unimpaired")


return {
  plugins = plugins,
  defer = defer,
}
