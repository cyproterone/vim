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


local nil_map = function (val, func)

  if val ~= nil
  then
    return func(val)
  else
    return nil
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


local make_set = function (tb)
  local lambda = function()
    return true
  end
  return map(tb, lambda)
end


local set_contains = function(set, key)
  return set[key] ~= nil
end


local pick = function (tb, keys)
  local set = make_set(tb)
  local lambda = function (v, key)
    return set_contains(set, key)
  end
  return filter(fb, lambda)
end


local exclude = function (tb, keys)
  local set = make_set(tb)
  local lambda = function (v, key)
    return not set_contains(set, key)
  end
  return filter(fb, lambda)
end


return {
  nil_map = nil_map,
  wrap = wrap,
  extract = extract,
  map = map,
  filter = filter,
  reduce = reduce,
  make_set = make_set,
  pick = pick,
  exclude = exclude,
}
