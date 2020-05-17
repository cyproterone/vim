local bindings = require "libs/bindings"
local registry = require "libs/registry"


--#################### Intrinsic Region ####################

local wild = function ()

  -- ui for cmd auto complete
  bindings.set("wildmenu")
  bindings.set("wildmode", "list:longest,full")
  bindings.set("wildignorecase")
  bindings.set("wildoptions", "tagfile")

  -- more history
  bindings.set("history", 10000)

  -- view messages
  bindings.map.normal("<Leader>m", ":messages<CR>")

end
registry.defer(wild)


-- enable smartcase
local smartcase = function ()

  bindings.set("ignorecase")
  bindings.set("smartcase")

  local on = function ()
    bindings.set("smartcase")
  end

  local off = function ()
    bindings.set("nosmartcase")
  end

  registry.auto("CmdLineEnter", off)
  registry.auto("CmdLineLeave", on)

end
registry.defer(smartcase)


--#################### FZF Region ####################

-- fzf
registry.install("junegunn/fzf")
registry.install("junegunn/fzf.vim")
local fzf_cmds = function ()

  bindings.source(scripts_home .. "/fzf.vim")

end
registry.defer(fzf_cmds)


local fzf = function ()

  -- fzf remove default border
  local fzf_opts = os.getenv("FZF_DEFAULT_OPTS")
  local fzf_newopts = fzf_opts .. " --no-border"
  bindings.env("FZF_DEFAULT_OPTS", fzf_newopts)

  -- fzf use fd
  bindings.env("FZF_DEFAULT_COMMAND", "fd -HL -t f -t l")

  -- fzf reuse buffers
  bindings.let("fzf_buffers_jump", true)

  -- fzf use preview
  bindings.let("fzf_preview_window", "right:wrap")

  bindings.let("fzf_layout",
               {window = {
                   width = 0.8,
                   height = 0.8}})

  -- keybindings
  bindings.map.normal("<C-p>", ":Commands<CR>")
  bindings.map.normal("<C-n>", ":History:<CR>")
  bindings.map.normal("<Leader>p", ":Files<CR>")
  bindings.map.normal("<Leader>P", ":History<CR>")
  bindings.map.normal("<Leader>o", ":BLines<CR>")
  bindings.map.normal("<Leader>O", ":Rg ", {silent = false})
  bindings.map.normal("<Leader>I", ":Buffers<CR>")
  bindings.map.normal("<Leader>M", ":Maps<CR>")

end
registry.defer(fzf)


--#################### Navi Region ####################

-- use [ ] to navigate various lists, ie quickfix
registry.install("tpope/vim-unimpaired")
