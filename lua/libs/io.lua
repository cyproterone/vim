--#################### ######### ####################
--#################### IO Region ####################
--#################### ######### ####################

local function exec (shell)
  local stream = assert(io.popen(shell))
  local acc = assert(stream:read("*a"))
  stream:close()
  return acc
end


local function file_exists (filename)
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
