--#################### ########## ####################
--#################### STD Region ####################
--#################### ########## ####################

local set = require "libs/set" 
local co = coroutine


local id = function (...)
  return ...
end

local count = function ()
  local i = 0
  return function ()
    i = i + 1
    return i 
  end
end


local range = function (start, stop, step)
  local nxt = start
  local step = step or 1
  assert(step ~= 0)
  local cmp = (function () 
    if step > 0 then
      return function (l, r) return l <= r end
    else
      return function (l, r) return l >= r end
    end
  end)()
  return co.wrap(function ()
    while cmp(nxt, stop) do
      co.yield(nxt)
      nxt = nxt + step 
    end
  end)
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


local wrap = function (val)
  if type(val) == "table" then
    return val
  else
    return {val}
  end
end


local keys = function (tb)
  local acc = {}
  for key, _ in pairs(tb) do
    table.insert(acc, key)
  end
  return acc
end


local values = function (tb)
  local acc = {}
  for _, val in pairs(tb) do
    table.insert(acc, val)
  end
  return acc
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


local pick = function (tb, keys)
  local st = set.new(tb)
  return filter(tb, function (val)
    return set.contains(st, val)
  end)
end


local exclude = function (tb, keys)
  local st = set.new(tb)
  return filter(tb, function (val)
    return not set.contains(st, val)
  end)
end


local concat = function (tbs)
  local acc = {}
  for _, tb in ipairs(tbs) do
    for _, val in ipairs(tb) do
      table.insert(acc, val)
    end
  end
  return acc
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
  count = count,
  range = range,
  len = len,
  keys = keys,
  values = values,
  wrap = wrap,
  extract = extract,
  foreach = foreach,
  map = map,
  flatmap = flatmap,
  filter = filter,
  reduce = reduce,
  pick = pick,
  exclude = exclude,
  concat = concat,
  merge = merge,
}
