--#################### ######### ####################
--#################### IO Region ####################
--#################### ######### ####################

local exec = function (shell)
  local stream = assert(io.popen(shell, "r"))
  local acc = assert(stream:read("*a"))
  stream:close()
  return acc
end


local pipe = function (shell, text)
  local stream = assert(io.popen(shell, "w"))
  assert(stream:write(text))
  stream:close()
end


return {
  exec = exec,
  pipe = pipe,
}
