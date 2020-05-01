--#################### ########## ####################
--#################### STD Region ####################
--#################### ########## ####################

local id = function (...)
  return ...
end


local len = function (tb)
  local l = 0
  for _, _ in pairs(tb) do
    l = l + 1
  end
  return l
end


local extract = function (path)
  return function (tb)
    local acc = tb
    for _, p in ipairs(path) do
      acc = acc[p]
    end
    return acc
  end
end


local nil_map = function (val, func)
  if val ~= nil then
    return func(val)
  else
    return nil
  end
end


local wrap = function (val)
  if type(val) == "table" then
    return val
  else
    return {val}
  end
end


local foreach = function (tb, func)
  for _, val in ipairs(tb) do
    func(val)
  end
end


local map = function (tb, func)
  local acc = {}
  for key, val in pairs(tb) do
    acc[key] = func(val, key)
  end
  return acc
end


local flatmap = function (tb, func)
  local acc = {}
  for key, val in pairs(tb) do
    table.insert(acc, func(val, key))
  end
  return acc
end


local filter = function (tb, func)
  local acc = {}
  for key, val in pairs(tb) do
    if func(val, key) then
      acc[key] = val
    end
  end
  return acc
end


local reduce = function (tb, init, func)
  local acc = init
  for key, val in pairs(tb) do
    acc = func(acc, val, key)
  end
  return acc
end


local make_set = function (tb)
  local acc = {}
  for _, val in ipairs(tb) do
    acc[val] = true
  end
  return acc
end


local set_contains = function(set, key)
  return set[key] ~= nil
end


local pick = function (tb, keys)
  local set = make_set(tb)
  return filter(tb, function (val)
    return set_contains(set, val)
  end)
end


local exclude = function (tb, keys)
  local set = make_set(tb)
  return filter(tb, function (val)
    return not set_contains(set, val)
  end)
end


local merge = function (tbs)
  local acc = {}
  for _, tb in ipairs(tbs) do
    for key, val in pairs(tb) do
      acc[key] = val
    end
  end
  return acc
end


return {
  id = id,
  len = len,
  nil_map = nil_map,
  wrap = wrap,
  extract = extract,
  foreach = foreach,
  map = map,
  flatmap = flatmap,
  filter = filter,
  reduce = reduce,
  make_set = make_set,
  pick = pick,
  exclude = exclude,
  merge = merge,
}
