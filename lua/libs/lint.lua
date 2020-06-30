local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local std = require "libs/std"


--#################### Pretty Region ####################

local _linters = {}
local _linter_assoc = {}

local linter_type = {stream="stream", fs="fs"}


local add_linter = function (prog, linter_type, args)
  _linters[prog] = {linter_type=linter_type, prog=prog, args=args}
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


local lint_args = function (args)
  local filename = vim.fn.bufname("%")
  local new_args = std.map(args, function (arg)
    if arg == "%" then
      return filename
    else
      return arg
    end
  end)
  return new_args
end


local open_preview = function ()
  for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
    if api.nvim_win_get_option(win, "previewwindow") then
      return win
    end
  end
  bindings.exec[[new]]
  vim.wo.previewwindow = true
  return 0
end


local print_message = function (code, err, out)
  local msg = (code == 0 and "成功" or "失败") .. "\n"
  local lines = msg .. err .. out
  local new_lines = vim.split(lines, "\n", true)

  a.wait(loop.main)
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(buf, 0, -1, true, new_lines)
  local height = math.min(vim.o.previewheight, #new_lines)
  local win = open_preview()
  api.nvim_win_set_buf(win, buf)
  api.nvim_win_set_height(win, height)
end


local lint_stream = function (prog, args)
  local lines = api.nvim_buf_get_lines(0, 0, -1, true)
  a.sync(function ()
    local args = {args = lint_args(args),
                  stream = table.concat(lines, "\n")}
    local code, out, err = a.wait(loop.spawn(prog, args))
    print_message(code, err, out)
  end)()
end


local lint_fs = function (prog, args)
  a.sync(function ()
    local args = {args = lint_args(args)}
    local code, out, err = a.wait(loop.spawn(prog, args))
    print_message(code, err, out)
  end)()
end


local do_lint = function ()
  local ft = vim.bo.filetype
  local linter = _linter_assoc[ft]

  if linter == nil then
    error("no linter associated with ft -- " .. ft)
  else
    local lint = (function ()
      local lint_type = linter.linter_type
      if lint_type == linter_type.stream then
        return lint_stream
      elseif lint_type == linter_type.fs then
        return lint_fs
      else
        error("unknown lint type -- " .. linter_type)
      end
    end)()
    lint(linter.prog, linter.args)
  end
end


return {
  linter_type = linter_type,
  add_linter = add_linter,
  assoc_linter = assoc_linter,
  do_lint = do_lint,
}
