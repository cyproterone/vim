--#################### ########## ####################
--#################### Lib Region ####################
--#################### ########## ####################
local std = require "libs/std"


local p_val = nil
p_val = function (val)

  local reduce = function (acc, val, key)
    assert(type(key) == "string")
    local trans = "'" .. key .. "' : " .. p_val(val)
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


local let = function (opt, val, scope)

  local scope = scope or "g"
  local cmd = "let " .. scope .. ":" .. opt .. " = " .. p_val(val)

  api.nvim_command(cmd)
end


local set = function (opt, val, operator)
  local p_statement = function ()
    if (not val)
    then
      return "set " .. opt
    elseif (not operator)
    then
      return "set " .. opt .. "=" ..val
    else
      return "set " .. opt .. operator ..  val
    end
  end

  api.nvim_command(p_statement())
end


local map = function ()

  local partial = function (prefix)
    return function (lhs, rhs)
      local rhs = rhs or "<Nop>"
      local cmd = prefix .. "noremap " .. lhs .. " " .. rhs
      api.nvim_command(cmd)
    end
  end

  return {
    normal = partial "n",
    command = partial "c",
    visual = partial "v",
    insert = partial "i",
    replace = partial "r",
    operator = partial "o"
  }
end


local auto = function (args)

  local group = assert(args.group)
  local events = table.concat(assert(args.events), ",")
  local filter = args.filter or "*"
  local exec = assert(args.exec)

  local auto_begin = "augroup " .. group
  local auto_cls = "autocmd!"
  local auto_body = "autocmd " .. events .. " " .. filter .. " " .. exec
  local auto_end = "augroup END"

  api.nvim_command(auto_begin)
  api.nvim_command(auto_cls)
  api.nvim_command(auto_body)
  api.nvim_command(auto_end)

end


local env = function (opt, val)

  local cmd = "let $" .. opt .. " = " .. p_val(val)
  api.nvim_command(cmd)

end


local source = function (path)

  local cmd = "source " .. path
  api.nvim_command(cmd)

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
