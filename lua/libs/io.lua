--#################### ######### ####################
--#################### IO Region ####################
--#################### ######### ####################

local exec = function (shell)
  local stream = assert(io.popen(shell))
  local acc = assert(stream:read("*a"))
  stream:close()
  return acc
end


local file_exists = function (filename)
  local file = io.open(filename, "r")
  if file
  then
    file:close()
    return true
  end
  return false
end


return {
  exec = exec,
  file_exists = file_exists,
}
