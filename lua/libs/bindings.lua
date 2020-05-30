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
    nv = partial{"n", "v"},
    ni = partial{"n", "i"},
    nic = partial{"n", "i", "c"},
    niv = partial{"n", "i", "v"},
  }
end


local source = function (path)
  api.nvim_command("source " .. path)
end


local buf = function (id)

  local let = function (var, val)
    return api.nvim_buf_set_var(id, var, val)
  end

  local var = function (var)
    return api.nvim_buf_get_var(id, var)
  end

  local set = function (var, val)
    return api.nvim_buf_set_option(id, var, val)
  end

  local opt = function (var)
    return api.nvim_buf_get_option(id, var)
  end

  return {
    let = let,
    var = var,
    set = set,
    opt = opt,
  }
end


local magic_escape = function (word)
  local escaped = fn.escape(word, [[/\]])
  return [[\V\<]] .. escaped .. [[\>]]
end


return {
  exec = exec,
  norm = norm,
  set = set,
  map = map(),
  source = source,
  buf = buf,
  magic_escape = magic_escape,
}
