--#################### ########## ####################
--#################### Lib Region ####################
--#################### ########## ####################
local std = require "libs/std"

local api = vim.api


local p_val = nil
p_val = function (val)

  local reduce = function (acc, val, key)
    local trans = p_val(key) .. " : " .. p_val(val)
    table.insert(acc, trans)
    return acc
  end

  if type(val) == "number"
  then
    return val
  elseif type(val) == "string"
  then
    return "'" .. val .. "'"
  elseif type(val) == "boolean"
  then
    return val and 1 or 0
  elseif type(val) == "table" and val[1] ~= nil
  then
    local entries = std.map(val, p_val)
    local cat = table.concat(entries, " , ")
    return "[" .. cat .. "]"
  elseif type(val) == "table"
  then
      local entries = std.reduce(val, {}, reduce)
      local cat = table.concat(entries, " , ")
      return "{" .. cat .. "}"
  else
    error("invalid type")
  end

end


local arbitrary = function (opt)

  api.nvim_command(opt)

end


local let = function (opt, val)

  api.nvim_set_var(opt, val)

end


local set = function (opt, val, operator)

  local p_statement = function ()
    if not val
    then
      return "set " .. opt
    elseif not operator
    then
      return "set " .. opt .. "=" .. val
    else
      return "set " .. opt .. operator ..  val
    end
  end

  if not operator
  then
    api.nvim_set_option(opt, val or true)
  else
    -- local prev = api.nvim_get_option(opt)
    api.nvim_command(p_statement())
  end

end


local map = function ()

  local partial = function (prefix)
    return function (lhs, rhs, opt)
      local rhs = rhs or ""
      local opt = opt or {}
      local options = std.merge{{noremap = true}, opt}
      for i, mode in ipairs(prefix)
      do
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
    nv = partial{"n", "v"},
    nov = partial{"n", "o", "v"},
  }
end


local auto = function (args)


  local group = assert(args.group)
  local events = table.concat(std.wrap(assert(args.events)), ",")
  local filter = args.filter or "*"
  local exec = std.wrap(assert(args.exec))

  local auto_begin = "augroup " .. group
  local auto_cls = "autocmd!"
  local auto_end = "augroup END"

  api.nvim_command(auto_begin)
  api.nvim_command(auto_cls)

  for _, exe in ipairs(exec)
  do
    local auto_body = "autocmd " .. events .. " " .. filter .. " " .. exe
    api.nvim_command(auto_body)
  end
  api.nvim_command(auto_end)

end


local env = function (opt, val)

  vim.loop.os_setenv(opt, val)

end


local source = function (path)

  api.nvim_command("source " .. path)

end


return {
  p_val = p_val,
  arbitrary = arbitrary,
  set = set,
  let = let,
  map = map(),
  auto = auto,
  env = env,
  source = source,
}
