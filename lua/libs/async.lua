--#################### ############ ####################
--#################### Async Region ####################
--#################### ############ ####################

local co = coroutine


local pong = function (thread)
  local next
  next = function ()
    local go, val = co.resume(thread)
    if go then
      co.resume(thread, val)
    end
  end
  next()
end


