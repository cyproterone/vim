--#################### ########## ####################
--#################### STD Region ####################
--#################### ########## ####################
local std = require "libs/std"


local split = function (code, str)
  local len = string.len(str) + 1
  local acc, prev = {}, 1
  for i in std.range(1, len) do
    if i == len then
      if prev ~= i then
        table.insert(acc, string.sub(str, prev, i - 1))
      end
      break
    end
    local b = string.byte(str, i)
    if b == code then
      table.insert(acc, string.sub(str, prev, i - 1))
      prev = i + 1
    end
  end
  return acc
end


local trim = function (code, str)
  local len = string.len(str)
  local fst = nil
  for i in std.range(1, len) do
    if string.byte(str, i) ~= code then
      fst = string.sub(str, i, len)
      break
    end
  end
  local len = string.len(fst)
  local snd = nil 
  for i in std.range(len, 1, -1) do
    if string.byte(fst, i) ~= code then
      snd = string.sub(fst, 1, i)
      break
    end
  end
  return snd
end


return {
  trim = trim,
  split = split,
}

