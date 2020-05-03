--#################### ############### ####################
--#################### Callback Region ####################
--#################### ############### ####################

local stack = require "libs/stack"


local throttle  = function (thunks, concurrency)
  local len = table.getn(thunks)
  local done = 0
  local acc, stk = {}, stack.new()

  local thunk = function (step)
    if len == 0 then
      return step()
    end
    for i, tk in ipairs(thunks) do
      assert(type(tk) == "function", "thunk must be function")
      local callback = function (...)
        acc[i] = {...}
        done = done + 1
        if done == len then
          step(acc)
        end
        local t, c = unpack(stk.pop({function () end}))
        t(c)
      end
      stk.push({tk, callback})
    end
    for i = 1, concurrency do
      local t, c = unpack(stk.pop({function () end}))
      t(c)
    end
  end
  return thunk
end


return {
  throttle = throttle,
}
