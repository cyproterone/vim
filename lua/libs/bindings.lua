--#################### ############### ####################
--#################### Bindings Region ####################
--#################### ############### ####################
local std = require "libs/std"


local p_val = nil
p_val = function (val)
  local reduce = function (acc, val, key)
    local trans = p_val(key) .. " : " .. p_val(val)
    table.insert(acc, trans)
    return acc
  end

  if type(val) == "number" then
    return val
  elseif type(val) == "string" then
    return "'" .. val .. "'"
  elseif type(val) == "boolean" then
    return val and 1 or 0
  elseif type(val) == "table" and val[1] ~= nil then
    local entries = std.map(val, p_val)
    local cat = table.concat(entries, " , ")
    return "[" .. cat .. "]"
  elseif type(val) == "table" then
      local entries = std.reduce(val, {}, reduce)
      local cat = table.concat(entries, " , ")
      return "{" .. cat .. "}"
  else
    error("invalid type")
  end
end


local exec = function (opt)
  api.nvim_command(opt)
end


local let = function (opt, val)
  api.nvim_set_var(opt, val)
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
  local partial = function (prefix)
    return function (lhs, rhs, opt)
      local rhs = rhs or ""
      local opt = opt or {}
      local base = {noremap = true, silent = true}
      local options = std.merge{base, opt}
      for i, mode in ipairs(prefix) do
        api.nvim_set_keymap(mode, lhs, rhs, options)
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
    nov = partial{"n", "o", "v"},
  }
end


local env = function (opt, val)
  vim.loop.os_setenv(opt, val)
end


local source = function (path)
  api.nvim_command("source " .. path)
end


local buf = function ()

  local let = function (buf, var, val)
    return api.nvim_buf_set_var(buf, var, val)
  end

  local var = function (buf, var)
    return api.nvim_buf_get_var(buf, var)
  end

  local set = function (buf, var, val)
    return api.nvim_buf_set_option(buf, var, val)
  end

  local opt = function (buf, var)
    return api.nvim_buf_get_option(buf, var)
  end

  return {
    let = let,
    var = var,
    set = set,
    opt = opt,
  }
end


local win = function ()

  local let = function (win, var, val)
    return api.nvim_win_set_var(win, var, val)
  end

  local var = function (win, var)
    return api.nvim_win_get_var(win, var)
  end

  local set = function (win, var, val)
    return api.nvim_win_set_option(win, var, val)
  end

  local opt = function (win, var)
    return api.nvim_win_get_option(win, var)
  end

  return {
    let = let,
    var = var,
    set = set,
    opt = opt,
  }
end


local call = function (name, ...)
  local len = select("#", ...)
  if len == 2 then
    local dict, args = ...
    return api.nvim_call_dict_function(name, dict, args)
  elseif len == 1 then
    local args = ...
    return api.nvim_call_function(name, args)
  else
    error("wrong number of arguments")
  end
end


return {
  p_val = p_val,
  exec = exec,
  set = set,
  let = let,
  map = map(),
  env = env,
  source = source,
  call = call,
  buf = buf(),
  win = win(),
}
