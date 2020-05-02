--#################### ############ ####################
--#################### Stack Region ####################
--#################### ############ ####################


local function new ()
  local store = {}
  local count = 0

  local function push (el)
    count = count + 1
    store[count] = el
  end

  local function pop (default)
    if count == 0 then
      return default
    else
      local val = store[count]
      store[count] = nil
      count = count - 1
      return val
    end
  end

  return {
    push = push,
    pop = pop,
  }
end


return {
  new = new
}
