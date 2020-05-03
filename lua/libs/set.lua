--#################### ########## ####################
--#################### Set Region ####################
--#################### ########## ####################


local new = function (tb)
  local acc = {}
  for _, val in ipairs(tb) do
    acc[val] = true
  end
  return acc
end


local contains = function (set, key)
  return set[key] ~= nil
end


local add = function (set, key)
  set[key] = true
end


local subtract = function (set, key)
  set[key] = nil
end


local union = function (a, b)
  local acc = {}
  for key, _ in pairs(a) do
    acc[key] = true
  end
  for key, _ in pairs(b) do
    acc[key] = true
  end
  return acc 
end


local intersection = function (a, b)
  local acc = {}
  for key, _ in pairs(a) do
    if contains(b, key) then
      acc[key] = true
    end
  end
  for key, _ in pairs(b) do
    if contains(a, key) then
      acc[key] = true
    end
  end
  return acc
end


local difference = function (a, b) 
  local acc = {}
  for key, _ in pairs(a) do
    if not contains(b, key) then
      acc[key] = true
    end
  end
  return acc
end


local symmetric_difference = function (a, b)
  local acc = {}
  for key, _ in pairs(a) do
    if not contains(b, key) then
      acc[key] = true
    end
  end
  for key, _ in pairs(b) do
    if not contains(a, key) then
      acc[key] = true
    end
  end
  return acc
end


return {
  new = new,
  contains = contains,
  add = add,
  subtract = subtract,
  union = union,
  intersection = intersection,
  difference = difference,
  symmetric_difference = symmetric_difference
}
