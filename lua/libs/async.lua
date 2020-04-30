--#################### ############ ####################
--#################### Async Region ####################
--#################### ############ ####################

local co = coroutine


-- sync version
-- thread :: coroutine[unit]
local pong = function (thread)
  local next
  next = function (go, ...)
    if not go then
      return
    end
    return next(co.resume(thread, ...))
  end
  return next(co.resume(thread))
end


-- async version
