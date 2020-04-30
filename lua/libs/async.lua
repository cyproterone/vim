--#################### ############ ####################
--#################### Async Region ####################
--#################### ############ ####################

local co = coroutine


-- reference
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


-- many thunks -> single thunk
local join = function (thunks)
  local len = table.getn(thunks)
  local done = 0
  local acc = {}

  local thunk = function (step)
    for i, thunk in ipairs(thunks) do
      local callback = function (...)
        acc[i] = {...}
        done = done + 1
        if done == len then
          step(unpack(acc))
        end
      end
      thunk(callback)
    end
  end
  return thunk
end


-- use with wrap
local pong = function (thread, callback)
  local step
  step = function (...)
    local go, ret = co.resume(thread, ...)
    if not (go and ret) then
      return (callback or function () end)()
    end
    if type(ret) == "table" then
      return join(ret)(step)
    else
      return ret(step)
    end
  end
  return step()
end


-- use with pong, creates thunk factory
local wrap = function (func)
  local factory = function (...)
    local params = {...}
    local thunk = function (step)
      table.insert(params, step)
      return func(unpack(params))
    end
    return thunk
  end
  return factory
end


return {
  pong = pong,
  wrap = wrap,
}
