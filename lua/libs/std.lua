--#################### ########## ####################
--#################### STD Region ####################
--#################### ########## ####################

local extract = function (path)
  return function (tb)
    local acc = tb
    for _, p in ipairs(path)
    do
      acc = acc[p]
    end
    return acc
  end
end


local wrap = function (val)

  if type(val) == "table"
  then
    return val
  else
    return {val}
  end

end


local map = function (tb, func)
      local acc = {}
      for key, val in pairs(tb)
      do
    acc[key] = func(val, key)
  end
  return acc
end


local filter = function (tb, func)
  local acc = {}
  for key, val in ipairs(tb)
  do
    if func(val, key)
    then
      acc[key] = val
    end
  end
  return acc
end


local reduce = function (tb, init, func)
  local acc = init
  for key, val in pairs(tb)
  do
    acc = func(acc, val, key)
  end
  return acc
end


return {
  wrap = wrap,
  extract = extract,
  map = map,
  filter = filter,
  reduce = reduce,
}
