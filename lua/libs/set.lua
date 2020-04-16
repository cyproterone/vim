--#################### ########## ####################
--#################### Lib Region ####################
--#################### ########## ####################


-- produce commands to set commands
local set_bindings = function ()

  local arbitrary = function (opt)
    return opt
  end


  local let = function ()

    local let_func = "let"

    local g = function (opt, val)
      return let_func .. " " .. "g:" .. opt .. " = "  .. val
    end

    return {
      g = g
    }

  end


  local set = function ()

    local set_func = "set"

    local plus = function (opt, val)
      return set_func .. " " .. opt .. "+=" .. val
    end

    local minus = function (opt, val)
      return set_func .. " " .. opt .. "-=" .. val
    end

    local eq = function (opt, val)
      return set_func .. " " .. opt .. "=" .. val
    end

    local id = function (opt)
      return set_func .. " " .. opt
    end

    return {
      plus = plus,
      minus = minus,
      eq = eq,
      id = id
    }

  end


  local map = function ()

    local map_func = "noremap"

    local normal = function (lhs, rhs)
      return "n" .. map_func .. " " .. lhs .. " " .. rhs
    end

    local command = function (lhs, rhs)
      return "c" .. map_func .. " " .. lhs .. " " .. rhs
    end

    local visual = function (lhs, rhs)
      return "v" .. map_func .. " " .. lhs .. " " .. rhs
    end

    local insert = function (lhs, rhs)
      return "i" .. map_func .. " " .. lhs .. " " .. rhs
    end

    local replace = function (lhs, rhs)
      return "r" .. map_func .. " " .. lhs .. " " .. rhs
    end

    local operator = function (lhs, rhs)
      return "o" .. map_func .. " " .. lhs .. " " .. rhs
    end

  end


  return {
    arbitrary = arbitrary,
    set = set(),
    let = let(),
    map = map(),
  }

end


bindings = set_bindings()
