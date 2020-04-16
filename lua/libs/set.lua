--#################### ########## ####################
--#################### Lib Region ####################
--#################### ########## ####################


-- produce defer to set defer
local set_bindings = function ()

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


  return {
    arbitrary = arbitrary,
    set = set,
    let = let,
    map = map(),
  }

end


bindings = set_bindings()
