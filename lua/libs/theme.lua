--#################### ############ ####################
--#################### Theme Region ####################
--#################### ############ ####################
local bindings = require "libs/bindings"


local override = function (highlights)

  local exec = {}

  for _, hi in ipairs(highlights) do
    local group = nil
    local options = {}
    for key, val in pairs(hi) do
      if key == 1 then
        group = val
      else
        local opt = key .. "=" .. val
        table.insert(options, opt)
      end
    end
    local prefix = "highlight " .. assert(group) .. " "
    local exe =  prefix .. table.concat(options, " ")
    table.insert(exec, exe)
  end

  bindings.auto{events = "ColorScheme",
                exec = exec}

end


return {
  override = override
}
