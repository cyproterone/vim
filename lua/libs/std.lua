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


local flat_map = function (tb, func)
  local acc = {}
  for i, val in ipairs(tb)
  do
    local t = func(val, i)
    for _, v in ipairs(t)
    do
      table.insert(acc, v)
    end
  end
  return acc
end


return {
  extract = extract,
  map = map,
  filter = filter,
  flat_map = flat_map,
}
