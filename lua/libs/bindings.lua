--#################### ########## ####################
--#################### Lib Region ####################
--#################### ########## ####################


local arbitrary = function (opt)
  api.nvim_command(opt)
end


local let = function (opt, val, scope)
  local scope = scope or "g"
  local cmd = "let " .. scope .. ":" .. opt .. " = " .. val
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

  local cmd = "let $" .. opt .. " = " .. val
  api.nvim_command(cmd)

end


return {
  arbitrary = arbitrary,
  set = set,
  let = let,
  map = map(),
  auto = auto,
  env = env,
}
