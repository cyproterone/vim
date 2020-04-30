--#################### ############ ####################
--#################### Async Region ####################
--#################### ############ ####################

local co = coroutine


local sync_pong = function (thread)
  local step
  step = function (go, ...)
    if not go then
      return
    end
    return step(co.resume(thread, ...))
  end
  return step(co.resume(thread))
end


-- use with wrap
local pong = function (thread)
  local step
  step = function (...)
    local go, ret = co.resume(thread, ...)
    if not (go and ret) then
      return
    end
    return ret(step)
  end
  return step()
end


-- use with pong
local wrap = function (func)
  return function (...)
    local params = {...}
    return function (step)
      table.insert(params, step)
      return func(unpack(params))
    end
  end
end


