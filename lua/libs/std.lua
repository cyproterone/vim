--#################### ########## ####################
--#################### STD Region ####################
--#################### ########## ####################

local standard_lib = function ()

  local map = function (tb, func)
    local acc = {}
    for i, val in ipairs(tb)
    do
      table.insert(acc, func(val, i))
    end
    return acc
  end


  local filter = function (tb, func)
    local acc = {}
    for i, val in ipairs(tb)
    do
      if (func(val, i))
      then
        table.insert(acc, val)
      end
    end
    return acc
  end


  return {
    map = map,
    filter = filter
  }
end

std = standard_lib()
