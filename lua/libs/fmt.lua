local a = require "libs/async"
local bindings = require "libs/bindings"
local loop = require "libs/loop"
local std = require "libs/std"


--#################### Pretty Region ####################

local _formatters = {}
local _formatter_assoc = {}


local add_fmt = function (prog, stdin, args)
  _formatters[prog] = {stdin=stdin, prog=prog, args=args}
end


local fmt_assoc = function (fmt, filetypes)
  local formatter = _formatters[fmt]
  if formatter ~= nil then
    error("fmt not found -- " .. fmt)
  else
    for _, ft in ipairs(filetypes) do
      _formatter_assoc[ft] = formatter
    end
  end
end


local fmt_stream = function (prog, args)
  local lines = api.nvim_buf_get_lines(0, 0, -1, true)
  a.sync(function ()
    local args = {args = args, stream = table.concat(lines)}
    local code, new_lines, err = a.wait(loop.spawn(prog, args))
    if code ~= 0 then
      error(table.concat(err, ""))
    else
      a.wait(loop.main)
      api.nvim_buf_set_lines(0, 0, -1, true, new_lines)
    end
  end)()
end


local fmt_fs = function (prog, args)
  a.sync(function ()
    local filename = vim.fn.bufname("%")
    local args = {args = std.concat{args, {filename}}}
    local code, _, err = a.wait(loop.spawn(prog, args))
    a.wait(loop.main)
    bindings.exec[[checktime]]
    if code ~= 0 then
      error(table.concat(err, ""))
    end
  end)()
end


local do_fmt = function()
  local ft = vim.bo.filetype
  local formatter = _formatter_assoc[ft]
  if formatter == nil then
    error("no fmt associated with ft -- " .. ft)
  else
    local fmt = formatter.stdin and fmt_stream or fmt_fs
    fmt(formatter.prog, formatter.args)
  end
end


return {
  add_fmt = add_fmt,
  fmt_assoc = fmt_assoc,
  do_fmt = do_fmt,
}
