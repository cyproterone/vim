--#################### ############ ####################
--#################### Async Region ####################
--#################### ############ ####################

local co = coroutine


-- reference
local sync_pong = function (thread)
  local step = nil
  step = function (go, ...)
    if not go then
      return
    end
    step(co.resume(thread, ...))
  end
  step(co.resume(thread))
end


-- used for reference equality
-- signal joining thunks in tb 
local ref = {} 


-- many thunks -> single thunk
local join = function (thunks)
  local len = table.getn(thunks)
  local done = 0
  local acc = {}

  local thunk = function (step)
    for i, tk in ipairs(thunks) do
      assert(type(tk) == "function", "thunk must be function")
      local callback = function (...)
        acc[i] = {...}
        done = done + 1
        if done == len then
          step(unpack(acc))
        end
      end
      tk(callback)
    end
  end
  return thunk
end


-- use with wrap
local pong = function (func, callback)
  assert(type(func) == "function", "type error :: expected func")
  local thread = co.create(func)

  local step = nil
  step = function (...)
    local go, ret = co.resume(thread, ...)
    if not go then
      assert(co.status(thread) == "suspended", ret)
    elseif type(ret) == "table" and ret[ref] then
      join(ret)(step)
    elseif type(ret) == "function" then
      ret(step)
    else
      (callback or function () end)(ret)
    end
  end

  step()
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


-- sugar over coroutine
local await = function (defer)
  if type(defer) == "table" then
    defer[ref] = true
    return co.yield(defer)
  elseif type(defer) == "function" then
    return co.yield(defer)
  else
    return assert(false, "type error :: expected func | table")
  end
end


return {
  sync = wrap(pong),
  wait = await,
  wrap = wrap,
}
