local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local std = require "libs/std"


--#################### Pretty Region ####################

local _formatters = {}
local _formatter_assoc = {}

local fmt_type = {lsp="lsp", stream="stream", fs="fs"}


local add_fmt = function (prog, fmt_type, mk_args)
  _formatters[prog] = {fmt_type=fmt_type, prog=prog, mk_args=mk_args}
end


local assoc_fmt = function (fmt, filetypes)
  local formatter = _formatters[fmt]
  if formatter == nil then
    error("fmt not found -- " .. fmt)
  else
    for _, ft in ipairs(filetypes) do
      _formatter_assoc[ft] = formatter
    end
  end
end


local fmt_lsp = function ()
  error("fmt_lsp")
end


local fmt_stream = function (prog, args)
  local lines = api.nvim_buf_get_lines(0, 0, -1, true)
  return a.sync(function ()
    local args = {args = args,
                  stream = table.concat(lines, "\n")}
    local code, text, err = a.wait(loop.spawn(prog, args))
    if code ~= 0 then
      error(err)
    else
      local new_lines = vim.split(text, "\n", true)
      a.wait(loop.main)
      api.nvim_buf_set_lines(0, 0, -1, true, new_lines)
      print("Formatted using -- " .. prog)
    end
  end)
end


local fmt_fs = function (prog, args)
  return a.sync(function ()
    local args = {args = args}
    local code, _, err = a.wait(loop.spawn(prog, args))
    a.wait(loop.main)
    bindings.exec[[checktime]]
    if code ~= 0 then
      error(err)
    else
      print("Formatted using -- " .. prog)
    end
  end)
end


local do_fmt = function ()
  if not vim.bo.modifiable then
    return
  end

  local ft = vim.bo.filetype
  local formatter = _formatter_assoc[ft]

  if formatter == nil then
    api.nvim_err_writeln("no fmt associated with ft -- " .. ft)
  else
    local fmt = (function ()
      local fm_type = formatter.fmt_type
      if fm_type == fmt_type.lsp then
        return fmt_lsp
      elseif fm_type == fmt_type.stream then
        return fmt_stream
      elseif fm_type == fmt_type.fs then
        return fmt_fs
      else
        error("unknown fmt type -- " .. fmt_type)
      end
    end)()

    a.sync(function ()
      local row, col = unpack(api.nvim_win_get_cursor(0))
      a.wait(fmt(formatter.prog, formatter.mk_args()))
      local new_row = math.min(row, api.nvim_buf_line_count(0))
      api.nvim_win_set_cursor(0, {new_row, col})
    end)()
  end
end


return {
  fmt_type = fmt_type,
  add_fmt = add_fmt,
  assoc_fmt = assoc_fmt,
  do_fmt = do_fmt,
}
