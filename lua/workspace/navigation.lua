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

end
registry.defer(wild)


-- enable smartcase
local smartcase = function ()

  bindings.set("ignorecase")
  -- bindings.set("smartcase")

  -- local on = function ()
  --   bindings.set("smartcase")
  -- end

  -- local off = function ()
  --   bindings.set("nosmartcase")
  -- end

  -- registry.auto("CmdLineEnter", off)
  -- registry.auto("CmdLineLeave", on)

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
  env["FZF_DEFAULT_OPTS"] = env["FZF_DEFAULT_OPTS"] .. " --no-border"

  -- fzf reuse buffers
  vim.g.fzf_buffers_jump = true

  -- fzf use preview
  vim.g.fzf_preview_window = "right:wrap"

  vim.g.fzf_layout = {window = {
    width = 0.9,
    height = 0.9}}

  -- keybindings
  bindings.map.normal("<c-p>",     "<cmd>Commands<cr>")
  bindings.map.normal("<c-n>",     "<cmd>History:<cr>")
  bindings.map.normal("<leader>p", "<cmd>Files<cr>")
  bindings.map.normal("<leader>P", "<cmd>History<cr>")
  bindings.map.normal("<leader>o", "<cmd>BLines<cr>")
  bindings.map.normal("<leader>O", ":Rg ", {silent = false})
  bindings.map.normal("<leader>I", "<cmd>Buffers<cr>")

end
registry.defer(fzf)


--#################### Navi Region ####################

-- use [ ] to navigate various lists, ie quickfix
local unimpaired = function ()

  bindings.map.normal("[b", "<cmd>bprevious<cr>")
  bindings.map.normal("]b", "<cmd>bnext<cr>")

  lv.add_line = function (up)
    local row, _ = unpack(api.nvim_win_get_cursor(0))
    row = row - 1
    if up then
      local btm, top = row - 1, row
      local lines = api.nvim_buf_get_lines(0, btm, top, false)
      table.insert(lines, "")
      api.nvim_buf_set_lines(0, btm, top, true, lines)
    else
      local btm, top = row + 1, row + 2
      local lines = api.nvim_buf_get_lines(0, btm, top, true)
      table.insert(lines, 1, "")
      api.nvim_buf_set_lines(0, btm, top, true, lines)
    end
  end

  bindings.map.normal("[<space>", "<cmd>lua lv.add_line(true)<cr>")
  bindings.map.normal("]<space>", "<cmd>lua lv.add_line(false)<cr>")

end
registry.defer(unimpaired)
