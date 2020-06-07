--#################### ######### ####################
--#################### IO Region ####################
--#################### ######### ####################

local file_exists = function (filename)
  local file = io.open(filename, "r")
  if file then
    file:close()
    return true
  end
  return false
end


return {
  file_exists = file_exists,
}

