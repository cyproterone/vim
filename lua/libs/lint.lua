local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local std = require "libs/std"


--#################### Pretty Region ####################

local _linters = {}
local _linter_assoc = {}

local linter_type = {stream="stream", fs="fs"}


local add_linter = function (prog, linter_type, mk_args)
  _linters[prog] = {linter_type=linter_type, prog=prog, mk_args=mk_args}
end


local assoc_linter = function (lint, filetypes)
  local linter = _linters[lint]
  if linter == nil then
    error("linter not found -- " .. lint)
  else
    for _, ft in ipairs(filetypes) do
      _linter_assoc[ft] = linter
    end
  end
end


local open_preview = function ()
  for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
    if api.nvim_win_get_option(win, "previewwindow") then
      return win
    end
  end
  bindings.exec[[new]]
  local height = vim.o.previewheight
  vim.wo.previewwindow = true
  api.nvim_win_set_height(0, height)
  return api.nvim_get_current_win()
end


local print_message = function (code, err, out)
  local msg = (code == 0 and "成功" or "失败") .. "\n"
  local lines = msg .. err .. out
  local new_lines = vim.split(lines, "\n", true)

  a.wait(loop.main)
  local cwin = api.nvim_get_current_win()
  local win = open_preview()
  api.nvim_set_current_win(cwin)
  local buf = api.nvim_win_get_buf(win)
  api.nvim_buf_set_option(buf, "modifiable", true)
  api.nvim_buf_set_lines(buf, 0, -1, true, new_lines)
  api.nvim_buf_set_option(buf, "modifiable", false)
  api.nvim_win_set_buf(win, buf)
end


local lint_stream = function (prog, args)
  local lines = api.nvim_buf_get_lines(0, 0, -1, true)
  a.sync(function ()
    local args = {args = args,
                  stream = table.concat(lines, "\n")}
    local code, out, err = a.wait(loop.spawn(prog, args))
    print_message(code, err, out)
  end)()
end


local lint_fs = function (prog, args)
  a.sync(function ()
    local args = {args = args}
    local code, out, err = a.wait(loop.spawn(prog, args))
    print_message(code, err, out)
  end)()
end


local do_lint = function ()
  local ft = vim.bo.filetype
  local linter = _linter_assoc[ft]

  if linter == nil then
    api.nvim_err_writeln("no linter associated with ft -- " .. ft)
  else
      local lint_type = linter.linter_type
      if lint_type == linter_type.stream then
        lint_stream(linter.prog, linter.mk_args())
      elseif lint_type == linter_type.fs then
        lint_fs(linter.prog, linter.mk_args())
      else
        error("unknown lint type -- " .. linter_type)
    end
  end
end


return {
  linter_type = linter_type,
  add_linter = add_linter,
  assoc_linter = assoc_linter,
  do_lint = do_lint,
}
