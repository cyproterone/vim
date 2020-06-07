--#################### ################# ####################
--#################### Decorators Region ####################
--#################### ################# ####################
local loop = require "libs/loop"

local debounce = function (timeout, fn)
  local stop = nil
  return function (...)
    if stop ~= nil then
      stop()
    end
    stop = loop.set_timeout(timeout, fn, ...)
  end
end


return {
  debounce = debounce,
}

