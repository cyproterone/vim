--#################### ############### ####################
--#################### Bindings Region ####################
--#################### ############### ####################
local std = require "libs/std"


local exec = function (opt)
  api.nvim_command(opt)
end


local norm = function (exec)
  api.nvim_command([[silent execute "normal! ]] .. exec .. [["]])
end


local set = function (opt, val, operator)
  local p_statement = function ()
    if not val then
      return "set " .. opt
    elseif not operator then
      return "set " .. opt .. "=" .. val
    else
      return "set " .. opt .. operator ..  val
    end
  end

  api.nvim_command(p_statement())
end


local map = function ()
  local base = {noremap = true, silent = true}

  local partial = function (prefix)
    return function (lhs, rhs, opt)
      local rhs = rhs or ""
      local opt = opt or {}
      local options = std.merge{base, opt}
      if options.buffer then
        local buf = options.buffer
        options.buffer = nil
        for _, mode in ipairs(prefix) do
          api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
        end
      else
        for _, mode in ipairs(prefix) do
          api.nvim_set_keymap(mode, lhs, rhs, options)
        end
      end
    end
  end

  return {
    normal = partial{"n"},
    command = partial{"c"},
    visual = partial{"v"},
    insert = partial{"i"},
    replace = partial{"r"},
    operator = partial{"o"},
    terminal = partial{"t"},
    no = partial{"n", "o"},
    nv = partial{"n", "v"},
    ni = partial{"n", "i"},
    nov = partial{"n", "o", "v"},
  }
end


local source = function (path)
  api.nvim_command("source " .. path)
end


local p_op_marks = function (type)
  local m1, m2 = unpack(type and {"[", "]"} or {"<", ">"})
  local r1, c1 = unpack(api.nvim_buf_get_mark(0, m1))
  local r2, c2 = unpack(api.nvim_buf_get_mark(0, m2))
  return r1, c1, r2, c2
end


return {
  exec = exec,
  norm = norm,
  set = set,
  map = map(),
  source = source,
  p_op_marks = p_op_marks,
}

