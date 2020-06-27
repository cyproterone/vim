--#################### ################# ####################
--#################### Decorators Region ####################
--#################### ################# ####################
local loop = require "libs/loop"

local debounce = function (timeout, fn)
  local stop = nil
  local exec = function (...)
    local args = {...}
    vim.schedule(function () fn(unpack(args)) end)
  end
  return function (...)
    if stop ~= nil then
      stop()
    end
    stop = loop.set_timeout(timeout, exec, ...)
  end
end


return {
  debounce = debounce,
}
